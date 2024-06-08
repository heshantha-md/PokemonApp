//
//  SamplePokemonAppApp.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import SwiftUI

@main
struct SamplePokemonAppApp: App {
    // MARK: - PROPERTIES
    let pokemonService = PokemonService(manager: NetworkManager())
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            HomeView()
        }
        .environmentObject(pokemonService)
    }
}
