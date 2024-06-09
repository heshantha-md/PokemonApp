//
//  ContentView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel: HomeViewModel
    
    init(pokemonService: PokemonService) {
        _viewModel = StateObject(wrappedValue: HomeViewModel(service: pokemonService))
    }
    
    // MARK: - BODY
    var body: some View {
        // TODO: - Collection View to display Pokemons
        ZStack {
            ProgressView()
            List {
                ForEach(self.viewModel.pokemons.sorted(by: <)) { item in
                    Text(item.name ?? "N/A")
                }
            }
            .background(.red)
        }
        .task {
            initialSetup()
        }
    }
    
    // MARK: - PROPERTIES
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
