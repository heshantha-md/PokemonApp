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
    @StateObject private var pokemonService: PokemonService = PokemonService(manager: NetworkManager())
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            HomeView(pokemonService: pokemonService)
        }
    }
}
