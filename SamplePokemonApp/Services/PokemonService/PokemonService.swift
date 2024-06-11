//
//  PokemonService.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//
import SwiftUI

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
    /// This function will fetch Pokémon names using Network Manager (aka NetworkManager)
    ///
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @NetworkActor
    func fetchData(offset: Int) async throws {
        Task.detached(priority: .userInitiated) {
            // MARK: - Fetch all the available Pokémons
            guard let response: PokemonsResponseModel? = try await self.manager?.fetchData(.getPokemons(offset: offset)) else {
                return
            }
            
            // MARK: - Fetch the data related to each Pokémon
            response?.results.forEach { item in
                Task.detached(priority: .userInitiated) {
                    try await self.fetchData(by: item.name)
                }
            }
        }
    }
    
    /// This function will fetch data related to Pokémon by it's name using Network Manager (aka NetworkManager)
    ///
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @NetworkActor
    func fetchData(by name: String) async throws {
        Task.detached(priority: .userInitiated) {
            if var pokemon: Pokemon = try await self.manager?.fetchData(.getPokemon(name: name)) {
                if let species: PokemonSpecies = try await self.manager?.fetchData(.getPokemonSpecies(id: pokemon.id)) {
                    pokemon.set(color: PokeColor.pokemonColor(by: species.color.name.lowercased()))
                }
                await self.add(pokemon)
            }
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    /// This function will add each Pokemon to 'pokemons' list property
    /// - warning: This function run on the main thread because 'pokemons' property is published and will update the UI by it's observers.
    /// - parameter pokemon: A Pokemon object with all the related data of the Pokémon
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @MainActor
    private func add(_ pokemon: Pokemon) {
        self.pokemons.update(with: pokemon)
    }
}
