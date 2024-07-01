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
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @NetworkActor
    func fetchData(offset: Int) async throws {
        Task.detached(priority: .userInitiated) {
            // MARK: - Fetch all the available Pokémons
            guard let response: PokemonsResponseCodable? = try await self.nwManager?.fetchData(.getPokemons(offset: offset)) else {
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
    
    /// This function will load favorite Pokémon from Database.
    /// - returns: Will be publising the the returned data using internal 'pokemons' property.
    @NetworkActor
    func loadRemainingFavorites() async throws {
        if let dbManager = self.dbManager as? PokemonDatabaseManager {
            if let favorites = try await dbManager.fetchData() {
                let favoriteIds = Set(favorites.map { $0.id })
                let diff = favoriteIds.difference(from: Set(self.pokemons.map { $0.id }))
                let remainingIds = diff.filter { Array(favoriteIds).contains($0) }
                remainingIds.prefix(Constants.URLS.FAVORITE_DEFAULT_LIMIT).forEach { id in
                    Task.detached(priority: .userInitiated) {
                        try await self.fetchPokemon(by: id)
                    }
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
            if let pokemonDecodable: PokemonCodable = try await self.nwManager?.fetchData(.getFrom(url: url)) {
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
            if let pokemonDecodable: PokemonCodable = try await self.nwManager?.fetchData(.getPokemonByName(name)) {
                try await self.fetchPokemonSpecies(pokemon: pokemonDecodable.asPokemon())
            }
        }
    }
    
    /// This function will fetch data related to Pokémon by it's ID using Network Manager (aka NetworkManager)
    /// - parameter id: 'Int' type Pokémon ID
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @NetworkActor
    func fetchPokemon(by id: Int) async throws {
        Task.detached(priority: .userInitiated) {
            if let pokemonDecodable: PokemonCodable = try await self.nwManager?.fetchData(.getPokemonById(id)) {
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
            if let species: PokemonSpeciesDetailCodable = try await self.nwManager?.fetchData(.getFrom(url: pokemon.species.url)) {
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
    
    /// This function will add a specified Pokémon to the user's list of favorites using the Database Manager (aka PokemonDatabaseManager).
    /// - parameter pokemon: A 'Pokemon' object representing the Pokémon to be added to the favorites.
    /// - returns: Will be publising the the modified data using internal 'pokemons' property.
    @MainActor
    func addToFavorites(_ pokemon: Pokemon) async throws {
        pokemon.isFavorite = true
        self.pokemons.update(with: pokemon)
        if let dbManager = dbManager as? PokemonDatabaseManager {
            try await dbManager.add(pokemon: PokemonDB(id: pokemon.id))
        }
    }
    
    /// This function will remove a specified Pokémon from the user's list of favorites using the Database Manager (aka PokemonDatabaseManager).
    /// - parameter pokemon: A 'Pokemon' object representing the Pokémon to be added to the favorites.
    /// - returns: Will be publising the the modified data using internal 'pokemons' property.
    @MainActor
    func removeFromFavorites(_ pokemon: Pokemon) async throws {
        pokemon.isFavorite = false
        self.pokemons.update(with: pokemon)
        if let dbManager = dbManager as? PokemonDatabaseManager {
            try await dbManager.delete(item: PokemonDB(id: pokemon.id))
        }
    }
}
