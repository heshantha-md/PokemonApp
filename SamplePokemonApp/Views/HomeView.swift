//
//  ContentView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel: Model
    @State private var searchText: String = ""
    @State private var scrollTransection: CGFloat = 267
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    @State private var pokemonArr: PokemonsArr = []
    @State private var scrollTransectionTask: Task<Void, Never>?
    @State private var fetchTask: Task<Void, Never>?
    private var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 180, maximum: .infinity), spacing: 0)]
    private var pokemonService: PokemonService!
    var logoScale: CGFloat {
        withAnimation(.easeIn(duration: 0.2)) {
            let scaleValue = scrollTransection / 150
            return scaleValue > 1 ? 1 : scaleValue > 0.5 ? scaleValue : 0.5
        }
    }
    
    init(model: Model) {
        _viewModel = StateObject(wrappedValue: model)
    }
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { mainGeo in
            ZStack {
                VStack(spacing: 0) {
                    // MARK: - Header View
                    ZStack {
                        IMAGES.LOGO
                            .resizable()
                            .frame(maxWidth: 400)
                            .frame(height: 150)
                            .padding(.horizontal, 15)
                            .scaleEffect(logoScale)
                            .animation(.easeInOut(duration: 0.5), value: logoScale)
                            .offset(y: -50)
                            .padding(.bottom, -50)
                            .shadow(color: .black.opacity(logoScale < 1 ? 1 : 0), radius: 5, x: 3, y: 3)
                    }
                    .frame(minWidth: 300, maxWidth: .infinity)
                    .background {
                        Rectangle()
                            .fill(Color.accentColor.opacity(0.5))
                            .ignoresSafeArea(.all)
                            .opacity(logoScale < 1 ? 1 : 0)
                            .animation(.easeIn(duration: 0.1), value: logoScale)
                    }
                    .overlay(alignment: .bottom) {
                        // MARK: - Search Bar
                        HStack {
                            IMAGES.MAGNIFYING_GLASS_ICON
                                .font(.largeTitle)
                            
                            TextField(Constants.POKEMONS_NAME, text: $searchText)
                                .frame(height: 35)
                                .font(.system(.title3,
                                              design: .monospaced,
                                              weight: .heavy))
                                .padding(.horizontal, 10)
                                .background(.thinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                            
                            Button(Constants.CANCEL.uppercased()) {
                                didTapOnCancelButton()
                            }
                            .frame(width: 60)
                            .buttonStyle(SimpleButton())
                        }
                        .frame(minWidth: 0, maxWidth: 500)
                        .foregroundStyle(COLORS.SECONDARY_FONT_COLOR)
                        .padding(.horizontal, 15)
                        .padding(.bottom, 5)
                        .opacity(logoScale < 0.6 ? 1 : 0)
                        .animation(.easeIn(duration: 0.2), value: logoScale)
                    }
                    
                    // MARK: - Pokemon List
                    ScrollViewReader { proxy in
                        ScrollView {
                            LazyVGrid(columns: gridLayout) {
                                Section(footer: VStack {
                                                        if searchText.isEmpty {
                                                            ProgressView()
                                                                .frame(minWidth: 0, maxWidth: .infinity)
                                                                .frame(height: 30)
                                                                .tint(Color.accentColor)
                                                                .task {
                                                                    if pokemonArr.count > 0 {
                                                                        refreshListData()
                                                                    }
                                                                }
                                                        } else {
                                                            Button("\(Constants.SEARCH) '\(searchText)'") {
                                                                Task {
                                                                    do {
                                                                        try await viewModel.searchPokemonFromService(by: searchText)
                                                                    } catch {
                                                                        // TODO: - Need to handle the error
                                                                        print(error.localizedDescription)
                                                                    }
                                                                }
                                                            }
                                                            .frame(height: 30)
                                                            .buttonStyle(PrimaryButton())
                                                            .padding(.top, 20)
                                                            .padding(.bottom, 40)
                                                        }
                                                }) {
                                    ForEach(0..<self.pokemonArr.count, id: \.self) { index in
                                        let pokemon = pokemonBinding(pokemonArr[index])
                                        // MARK: - Pokemon Cell
                                        NavigationLink {
                                            PokemonSummaryView(model: PokemonSummaryView.Model(pokemon: pokemon, service: PokemonService(manager: NetworkManager())))
                                        } label: {
                                            PrimaryCollectionCellView(pokemon: pokemon).id(index)
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
                if pokemonArr.isEmpty {
                    refreshListData()
                }
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
                // TODO: - Need to handle the error
                print(error.localizedDescription)
            }
        }
    }
    
    /// This function will hide the search bar from the view and reset the entire view to default
    private func didTapOnCancelButton() {
        searchText = ""
        scrollTransection = 150
        scrollViewProxy?.scrollTo(0)
    }
    
    private func pokemonBinding(_ pokemon: Pokemon) -> Binding<Pokemon> {
        Binding<Pokemon>(get: { pokemon }, set: { self.viewModel.pokemons.update(with: $0) } )
    }
}

// MARK: - PREVIEW
#Preview {
    NavigationStack {
        HomeView(model: HomeView.Model(service: PokemonService(manager: MocNetworkManager())))
    }
}
