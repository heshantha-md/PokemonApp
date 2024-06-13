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
    /// Making default initializer function inaccessible as Network Manager Protocal (aka NetworkManagerProtocal) type object mandatory to function this class
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
            guard let response: PokemonsResponseDecodable? = try await self.manager?.fetchData(.getPokemons(offset: offset)) else {
                throw ApiError.badRequest
            }
            
            // MARK: - Fetch the data related to each Pokémon
            response?.results.forEach { item in
                Task.detached(priority: .userInitiated) {
                    try await self.fetchPokemonUsing(url: item.url)
                }
            }
        }
    }
    
    /// This function will fetch data related to Pokémon by the provided url using Network Manager (aka NetworkManager)
    /// - parameter url: 'String' type url to request Pokémon data from API endpoint which can be found when fetch all the Pokémon's with limits
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @NetworkActor
    func fetchPokemonUsing(url: String) async throws {
        Task.detached(priority: .userInitiated) {
            if let pokemonDecodable: PokemonDecodable = try await self.manager?.fetchData(.getFrom(url: url)) {
                try await self.fetchPokemonSpecies(pokemon: pokemonDecodable.asPokemon())
            }
        }
    }
    
    /// This function will fetch data related to Pokémon by it's name using Network Manager (aka NetworkManager)
    /// - parameter name: 'String' type Pokémon Name
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @NetworkActor
    func fetchPokemon(by name: String) async throws {
        Task.detached(priority: .userInitiated) {
            if let pokemonDecodable: PokemonDecodable = try await self.manager?.fetchData(.getPokemon(name: name)) {
                try await self.fetchPokemonSpecies(pokemon: pokemonDecodable.asPokemon())
            }
        }
    }
    
    /// This function will fetch data related to Pokémon Species by the provided url in the Pokemon DOT using Network Manager (aka NetworkManager)
    /// - parameter pokemon: A Pokemon object with all the related data of the Pokémon
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @NetworkActor
    func fetchPokemonSpecies(pokemon: Pokemon) async throws {
        Task.detached(priority: .userInitiated) {
            var pokemon = pokemon
            if let species: PokemonSpeciesDetailDecodable = try await self.manager?.fetchData(.getFrom(url: pokemon.species.url)) {
                pokemon.set(base_happiness: species.base_happiness,
                            capture_rate: species.capture_rate,
                            color: PokeColor.pokemonColor(by: species.color.name.lowercased()))
            }
            await self.add(pokemon)
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
