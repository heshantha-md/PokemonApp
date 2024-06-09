//
//  PokemonService.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//
import Foundation

final class PokemonService: ServiceProtocol {
    // MARK: - PROPERTIES
    @Published var pokemons: Pokemons = []
    let manager: NetworkManagerProtocal?
    
    // MARK: - INITIALIZERS
    /// Making default initializer function inaccessible as Network Manager Protocal (aka NetworkManagerProtocal) typed object mandatory to function this class
    private init() {
        self.manager = nil
    }
    required init(manager: NetworkManagerProtocal) {
        self.manager = manager
    }
    
    // MARK: - FUNCTIONS
    /// This function will fetch Pokemon data using Network Manager (aka NetworkManager)
    ///
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    func fetchData() async throws {
        Task(priority: .background) {
            // MARK: - Fetch all the available Pokemons
            guard let response: PokemonsResponseModel? = try await manager?.fetchData(.getPokemons(offset: 0)) else {
                return
            }
            
            // MARK: - Fetch the data related to each Pokemon
            response?.results.forEach { item in
                Task {
                    if var pokemon: Pokemon = try await manager?.fetchData(.getPokemon(name: item.name)) {
                        pokemon.set(name: item.name)
                        await self.add(pokemon)
                    }
                }
            }
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    /// This function will add each Pokemon to 'pokemons' list property
    /// - warning: This function run on the main thread because 'pokemons' property is published and will update the UI by it's observers.
    /// - parameter pokemon: A Pokemon object with all the related data of the Pokemon
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @MainActor
    private func add(_ pokemon: Pokemon) {
        self.pokemons.insert(pokemon)
    }
}
