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
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \PokemonDB.id) private var pokemonsDB: PokemonsDB
    
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var viewModel: HomeViewModel
    @State private var searchText: String = ""
    @State private var scrollTransection: CGFloat = 267
    @State private var scrollViewProxy: ScrollViewProxy? = nil
    @State private var pokemonsFilter: PokemonsDB = []
    @State private var scrollTransectionTask: Task<Void, Never>?
    @State private var fetchTask: Task<Void, Never>?
    private var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 180, maximum: .infinity), spacing: 0)]
    var logoScale: CGFloat {
        withAnimation(.easeIn(duration: 0.2)) {
            let scaleValue = scrollTransection / 150
            return scaleValue > 1 ? 1 : scaleValue > 0.5 ? scaleValue : 0.5
        }
    }
    
    init(pokemonService: PokemonService) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(service: pokemonService))
    }
    
    // MARK: - BODY
    var body: some View {
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
                                                                refreshListData()
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
                                                ForEach(0..<(pokemonsFilter.isEmpty ? pokemonsDB.count : pokemonsFilter.count), id: \.self) { index in
                                    // MARK: - Pokemon Cell
                                    PrimaryCollectionCellView(pokemon: Binding<PokemonDB>(get: { pokemonsDB[index] },
                                                                                          set: { viewModel.pokemons.update(with: $0.asPokemon) } )).id(index)
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
            Task {
                if !viewModel.pokemons.isEmpty {
                    var newValue: Pokemons = self.viewModel.pokemons
                    if !searchText.isEmpty {
                        pokemonsFilter = viewModel.searchPokemon(by: searchText)
                        newValue = pokemonsFilter.asPokemons
                        return
                    }
                    
                    await pokemonsDB.sync(with: newValue, in: modelContext)
                }
            }
        }
        .onChange(of: searchText) {
                // TODO: - Need to fix the search feature
//                Task {
//                    if !searchText.isEmpty {
//                        pokemonsFilter = viewModel.searchPokemon(by: searchText)
//                    }
//                }
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
}

// MARK: - PREVIEW
#Preview {
    HomeView(pokemonService: PokemonService(manager: MocNetworkManager()))
}
