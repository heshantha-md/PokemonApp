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
    @StateObject private var viewModel: HomeViewModel
    private var gridLayout: [GridItem] = [GridItem(.adaptive(minimum: 200, maximum: .infinity), spacing: 0)]
    
    init(pokemonService: PokemonService) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(service: pokemonService))
    }
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { mainGeo in
            ZStack {
                VStack(spacing: 0) {
                    // MARK: - Logo Image
                    ZStack {
                        IMAGES.LOGO
                            .resizable()
                            .frame(maxWidth: 400)
                            .frame(height: 150)
                            .padding(.horizontal, 15)
                    }
                    .frame(minWidth: 300, maxWidth: .infinity)
                    
                    // MARK: - Pokemon List
                    ScrollView {
                        LazyVGrid(columns: gridLayout) {
                            ForEach(self.viewModel.pokemons.sorted()) { pokemon in
                                // MARK: - Pokemon Cell
                                PrimaryCollectionCellView(pokemon: Binding<Pokemon>(get: { pokemon },
                                                                                    set: { self.viewModel.pokemons.update(with: $0) } ))
                            }
                        }
                        .padding(.horizontal, 10)
                        .padding(.bottom, 30)
                    }
                    .task {
                        // MARK: - Initial Setup
                        initialSetup()
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
        }
    }
    
    // MARK: - FUNCTIONS
    /// This function will execute the configurations related to initial setting up of the view
    private func initialSetup() {
        refreshListData()
    }
    
    /// This function will refresh data in the list (aka Collection View)
    private func refreshListData() {
        do {
            try viewModel.fetchData()
        } catch {
            // TODO: - Need to handle the error
            print(error.localizedDescription)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    HomeView(pokemonService: PokemonService(manager: MocNetworkManager()))
}
