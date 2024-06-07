//
//  PokemonService.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//
import Observation

@Observable
final class PokemonService: ServiceProtocol {
    // MARK: - PROPERTIES
    var pokemons: Set<Pokemon> = []
    var manager: any NetworkManagerProtocal
    
    // MARK: - INITIALIZERS
    required init(manager: any NetworkManagerProtocal) {
        self.manager = manager
    }
    
    // MARK: - FUNCTIONS
    func fetch() async throws {
        Task(priority: .background) {
            guard let response: PokemonsResponseModel? = try await manager.fetch(.getPokemons(offset: 0)) else {
                return
            }
            
            response?.results.forEach { item in
                Task {
                    if let pokemon: Pokemon = try await manager.fetch(.getPokemon(name: item.name)) {
                        await self.add(pokemon)
                    }
                }
            }
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    @MainActor
    private func add(_ pokemon: Pokemon) {
        self.pokemons.insert(pokemon)
    }
}
