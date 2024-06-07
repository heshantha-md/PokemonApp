//
//  ContentView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: - PROPERTIES
    @Environment(PokemonService.self) var service
    
    // MARK: - BODY
    var body: some View {
        // MARK: - Testing
        /// Testing code starts
        List {
            ForEach(self.service.pokemons.sorted(by: <)) { item in
                Text(item.sprites.backDefault ?? "N/A")
            }
        }
        .task {
            do {
                try await self.service.fetch()
            } catch {
                print(error.localizedDescription)
            }
        }
        /// Testing code ends
    }
}

// MARK: - PREVIEW
#Preview {
    HomeView()
}
