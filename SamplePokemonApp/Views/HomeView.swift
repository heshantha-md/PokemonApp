//
//  ContentView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    @EnvironmentObject var service: PokemonService
    @State var viewModel: HomeViewModel?
    
    // MARK: - BODY
    var body: some View {
        // TODO: - Collection View to display Pokemons
        List {
            ForEach(self.viewModel?.pokemons.sorted(by: <) ?? []) { item in
                Text(item.sprites.backDefault ?? "N/A")
            }
        }
        .task {
            await initialSetup()
        }
    }
    
    // MARK: - PROPERTIES
    /// This function will execute the configurations related to initial setting up of the view
    private func initialSetup() async {
        self.viewModel = HomeViewModel(service: service)
        refreshListData()
    }
    
    /// This function will refresh data in the list (aka Collection View)
    private func refreshListData() {
        if let viewModel {
            Task(priority: .background) {
                do {
                    try await viewModel.fetch()
                } catch {
                    // TODO: - Need to handle the error
                    print(error.localizedDescription)
                }
            }
        }
    }
}

// MARK: - PREVIEW
#Preview {
    NavigationStack {
        HomeView()
            .environmentObject(PokemonService(manager: NetworkManager()))
    }
}
