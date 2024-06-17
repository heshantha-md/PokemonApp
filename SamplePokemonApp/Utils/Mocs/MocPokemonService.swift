//
//  MocPokemonService.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 16/06/2024.
//

struct MocPokemonService {
    static let service = PokemonService(networkManager: MocNetworkManager(),
                                        databaseManager: PokemonDatabaseManager(context: SamplePokemonAppApp.sharedModelContainer))
}
