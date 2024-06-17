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
    static var sharedModelContainer: ModelContainer = {
        let schema = Schema(SamplePokemonAppApp.modelContainer)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    @StateObject var pokemonService = PokemonService(networkManager: NetworkManager(),
                                               databaseManager: PokemonDatabaseManager(context: SamplePokemonAppApp.sharedModelContainer))
    
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(model: HomeView.Model(service: pokemonService))
            }
        }
        .environmentObject(pokemonService)
    }
}

// MARK: - STATIC PROPERTIES
extension SamplePokemonAppApp {
    static let modelContainer: [any PersistentModel.Type] = [PokemonDB.self]
}
