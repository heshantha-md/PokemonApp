//
//  ContentView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var pokemonService: PokemonService
    @StateObject private var viewModel: Model
    @State private var searchText: String = ""
    @State private var scrollTransection: CGFloat = 267
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    @State private var pokemonArr: PokemonsArr = []
    @State private var scrollTransectionTask: Task<Void, Never>?
    @State private var fetchTask: Task<Void, Never>?
    @State private var fetchFavoritesTask: Task<Void, Never>?
    @State private var viewError: ViewError?
    private var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 180, maximum: .infinity), spacing: 0)]
    
    // MARK: - INITIALIZERS
    init(model: Model) {
        _viewModel = StateObject(wrappedValue: model)
    }
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { mainGeo in
            ZStack {
                VStack(spacing: 0) {
                    // MARK: - Navigation Bar
                    HomeNavigationBar(scrollTransection: $scrollTransection,
                                      searchText: $searchText,
                                      searchCancelAction: {
                        resetView()
                    })
                    .accessibilityElement(children: .combine)
                    .accessibilityLabel("Navigation Bar")
                    .accessibilityHint("Search for a Pokémon")
                    
                    // MARK: - Pokemon List
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVGrid(columns: gridLayout) {
                                Section(footer: VStack {
                                                        if searchText.isEmpty {
                                                            ProgressView()
                                                                .frame(maxWidth: .infinity)
                                                                .frame(height: 30)
                                                                .tint(Color.accentColor)
                                                                .task {
                                                                    if pokemonArr.count > 0 {
                                                                        refreshListData()
                                                                    }
                                                                }
                                                                .accessibilityHidden(true)
                                                        } else {
                                                            Button("\(Constants.SEARCH) '\(searchText)'") {
                                                                Task {
                                                                    do {
                                                                        try await viewModel.searchPokemonFromService(by: searchText)
                                                                    } catch {
                                                                        viewError = ViewError.badResponseForSearchPokemonFromService(error: error.localizedDescription)
                                                                    }
                                                                }
                                                            }
                                                            .frame(maxWidth: 250)
                                                            .frame(height: 30)
                                                            .buttonStyle(PrimaryButton())
                                                            .padding(.top, 20)
                                                            .padding(.bottom, 40)
                                                            .accessibilityLabel("Search Pokémon")
                                                            .accessibilityHint("Search for a Pokémon named \(searchText)")
                                                        }
                                                }) {
                                    
                                    ForEach(pokemonArr.indices, id: \.self) { index in
                                        let pokemon = pokemonArr[index].binding { pokemon in
                                            self.viewModel.pokemons.update(with: pokemon)
                                        }
                                        
                                        // MARK: - Pokemon Cell
                                        NavigationLink {
                                            PokemonSummaryView(model: PokemonSummaryView.Model(pokemon: pokemon, service: pokemonService))
                                        } label: {
                                            PrimaryCollectionCellView(pokemon: pokemon, favoriteAction: { isFavorite in
                                                Task.detached(priority: .userInitiated) {
                                                    let pokemon = await pokemonArr[index]
                                                    isFavorite ? try await viewModel.removeFromFavorites(pokemon) : try await viewModel.addToFavorites(pokemon)
                                                }
                                            }).id(index)
                                        }
                                    }
                                }
                            }
                            .background(
                                GeometryReader { inner in
                                    Color.clear.preference(key: ScrollOffsetPreferenceKey.self, value: inner.frame(in: .global).origin.y)
                                }
                            )
                            .padding(.horizontal, 10)
                        }
                        .onAppear {
                            scrollViewProxy = proxy
                        }
                    }
                    .refreshable {
                        // MARK: - Drag to refresh
                        refreshListData()
                    }
                    .accessibilityAction(named: "Refresh Pokémon List") {
                        refreshListData()
                    }
                    
                    // MARK: - Favorite Pokémon
                    let favoritePokemons = pokemonArr.favorites.sorted()
                    VStack(alignment: .leading, spacing: -10) {
                        // MARK: - Favorite Title
                        Text(Constants.TITLES.FAVOURITES)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .font(.system(.subheadline, weight: .heavy))
                                .padding(.horizontal, 20)
                                .padding(.vertical, 2)
                                .foregroundStyle(.white)
                        
                        // MARK: - Favorite List
                        ScrollViewReader { proxy in
                            ScrollView(.horizontal, showsIndicators: false) {
                                LazyHGrid(rows: [GridItem(.fixed(80))], spacing: 0) {
                                    Section(footer: VStack {
                                            if pokemonArr.count > 0 {
                                                ProgressView()
                                                    .frame(maxWidth: .infinity)
                                                    .frame(height: 30)
                                                    .tint(Color.accentColor)
                                                    .task {
                                                        loadMoreFavorites()
                                                    }
                                                    .accessibilityHidden(true)
                                            }
                                    }) {
                                        ForEach(favoritePokemons.indices, id: \.self) { index in
                                            let pokemon = favoritePokemons[index].binding { pokemon in
                                                self.viewModel.pokemons.update(with: pokemon)
                                            }
                                            
                                            // MARK: - Pokemon Cell
                                            NavigationLink {
                                                PokemonSummaryView(model: PokemonSummaryView.Model(pokemon: pokemon, service: pokemonService))
                                            } label: {
                                                PrimaryCollectionCellView(pokemon: pokemon, favoriteAction: { isFavorite in
                                                    Task.detached(priority: .userInitiated) {
                                                        let pokemon = favoritePokemons[index]
                                                        isFavorite ? try await viewModel.removeFromFavorites(pokemon) : try await viewModel.addToFavorites(pokemon)
                                                    }
                                                }).id(index)
                                            }
                                        }
                                    }
                                }
                                .onAppear {
                                    proxy.scrollTo(favoritePokemons.last?.id, anchor: .center)
                                }
                            }
                            .frame(height: 160)
                        }
                    }
                    .padding(.top, 5)
                    .background() {
                        Rectangle()
                            .fill(.black.opacity(0.5))
                            .ignoresSafeArea()
                    }
                }
                .alert("\(viewError?.errorDescription ?? Constants.ERROR)", isPresented: .constant(viewError != nil)) {
                    Button(Constants.OK, role: .cancel) { viewError = nil }
                }
            }
            .ignoresSafeArea(edges: .bottom)
            .background {
                // MARK: - Background Image
                Group {
                    colorScheme == .dark ?
                        IMAGES.NIGHT_BACKGROUND :
                        IMAGES.DAY_BACKGROUND
                }
            }
            .onChange(of: self.viewModel.pokemons, initial: false) {
                Task.detached(priority: .userInitiated) {
                    await MainActor.run {
                        pokemonArr = searchText.isEmpty ?
                                        viewModel.pokemons.sorted() :
                                        viewModel.searchPokemon(by: searchText)
                    }
                }
            }
            .onChange(of: searchText) {
                Task.detached(priority: .userInitiated) {
                    await MainActor.run {
                        pokemonArr = viewModel.searchPokemon(by: searchText)
                    }
                }
            }
            .onChange(of: viewModel.error) {
                self.viewError = viewModel.error
            }
            .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                if searchText.isEmpty {
                    scrollTransectionTask?.cancel()
                    scrollTransectionTask = Task(priority: .utility) {
                        await MainActor.run {
                            scrollTransection = value
                        }
                    }
                }
            }
            .task {
                await onTaskSetup()
            }
            .toolbar(.hidden)
        }
    }
    
    // MARK: - FUNCTIONS
    /// This function will refresh data in the list (aka Collection View)
    private func refreshListData() {
        fetchTask?.cancel()
        fetchTask = Task(priority: .userInitiated) {
            do {
                try await viewModel.fetchData()
            } catch {
                viewError = ViewError.badPokemonFetchDataResponse(error: error.localizedDescription)
            }
        }
    }
    
    /// This function will load more favorite Pokémon data
    private func loadMoreFavorites() {
        fetchFavoritesTask?.cancel()
        fetchFavoritesTask = Task(priority: .userInitiated) {
            do {
                try await viewModel.loadRemainingFavorites()
            } catch {
                viewError = ViewError.badPokemonFetchDataResponse(error: error.localizedDescription)
            }
        }
    }
    
    /// This function will hide the search bar from the view and reset the entire view to default
    private func resetView() {
        searchText = ""
        scrollTransection = 150
        scrollViewProxy?.scrollTo(0)
    }
    
    private func onTaskSetup() async {
        if pokemonArr.isEmpty {
            refreshListData()
        }
    }
}

// MARK: - PREVIEW
#Preview {
    NavigationStack {
        HomeView(model: HomeView.Model(service: MocPokemonService.service))
    }
    .environmentObject(MocPokemonService.service)
}
