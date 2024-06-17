//
//  PokemonService.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

import SwiftUI

final class PokemonService: BaseService {
    // MARK: - PROPERTIES
    @Published var pokemons: Pokemons = []
    
    // MARK: - INITIALIZERS
    required init(networkManager: any NetworkManagerProtocol, databaseManager: any DatabaseManagerProtocol) {
        super.init(networkManager: networkManager, databaseManager: databaseManager)
    }
    
    // MARK: - FUNCTIONS
    /// This function will fetch Pokémon names using Network Manager (aka NetworkManager)
    ///
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @NetworkActor
    func fetchData(offset: Int) async throws {
        Task.detached(priority: .userInitiated) {
            // MARK: - Fetch all the available Pokémons
            guard let response: PokemonsResponseDecodable? = try await self.nwManager?.fetchData(.getPokemons(offset: offset)) else {
                throw ApiError.dataNotFound
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
            if let pokemonDecodable: PokemonDecodable = try await self.nwManager?.fetchData(.getFrom(url: url)) {
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
            if let pokemonDecodable: PokemonDecodable = try await self.nwManager?.fetchData(.getPokemon(name: name)) {
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
            if let species: PokemonSpeciesDetailDecodable = try await self.nwManager?.fetchData(.getFrom(url: pokemon.species.url)) {
                pokemon.set(base_happiness: species.base_happiness,
                            capture_rate: species.capture_rate,
                            color: PokeColor.pokemonColor(by: species.color.name.lowercased()))
            }
            try await self.add(pokemon)
        }
    }
    
    // MARK: - PRIVATE FUNCTIONS
    /// This function will add each Pokemon to 'pokemons' list property
    /// - warning: This function run on the main thread because 'pokemons' property is published and will update the UI by it's observers.
    /// - parameter pokemon: A Pokemon object with all the related data of the Pokémon
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @MainActor
    private func add(_ pokemon: Pokemon) async throws {
        var newPokemon = pokemon
        if let dbManager = dbManager as? PokemonDatabaseManager {
            try await dbManager.sync(&newPokemon)
        }
        self.pokemons.update(with: newPokemon)
    }
    
    /// This function will add a specified Pokémon to the user's list of favorites using the service provided.
    /// - parameter pokemon: A 'Pokemon' object representing the Pokémon to be added to the favorites.
    /// - returns: Will be publising the the returned data using internal 'pokemons' property.
    @MainActor
    func addToFavorites(_ pokemon: Pokemon) async throws {
        pokemon.isFavorite.toggle()
        self.pokemons.update(with: pokemon)
        if let dbManager = dbManager as? PokemonDatabaseManager {
            try await dbManager.updateOrAddIfNotFound(pokemon)
        }
    }
}
