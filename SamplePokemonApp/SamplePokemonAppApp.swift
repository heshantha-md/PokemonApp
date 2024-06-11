//
//  SamplePokemonAppApp.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import SwiftUI
import SwiftData

@main
struct SamplePokemonAppApp: App {
    // MARK: - PROPERTIES
    var sharedModelContainer: ModelContainer = {
        let schema = Schema(SamplePokemonAppApp.modelContainer)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject private var pokemonService: PokemonService = PokemonService(manager: NetworkManager())
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            HomeView(pokemonService: pokemonService)
        }
        .modelContainer(sharedModelContainer)
    }
}

// MARK: - STATIC PROPERTIES
extension SamplePokemonAppApp {
    static let modelContainer: [any PersistentModel.Type] = [PokemonDB.self,
                                                             SpritesDB.self,
                                                             OtherSpritesDB.self,
                                                             OfficialArtworkSpritesDB.self,
                                                             ShowdownArtworkSpritesDB.self]
}
