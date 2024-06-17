//
//  DatabaseManager.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 15/06/2024.
//

import SwiftUI
import SwiftData

final class PokemonDatabaseManager: BaseDatabaseManager {
    // MARK: - PROPERTIES
    private let sortDescriptors = [SortDescriptor(\PokemonDB.id)]
    
    // MARK: - FUNCTIONS
    /// This function will fetch all the Pokémon in the Database
    /// - returns: A List of Pokemon objects.
    @DatabaseActor
    func fetchData() async throws -> PokemonsDB? {
        do {
            let descriptor = FetchDescriptor<PokemonDB>(sortBy: sortDescriptors)
            return try mContext?.fetch(descriptor)
        } catch {
            throw DbError.dataFetchError(description: error.localizedDescription)
        }
    }
    
    /// This function will delete a given Persistent Model (aka PersistentModel) in the Database
    /// - parameter item: A PersistentModel of any Persistent Model object.
    @DatabaseActor
    override func delete(item: any PersistentModel) async throws {
        if let pokemon = item as? PokemonDB {
            guard let data = try await fetchData(), let tPokemon = data.first(where: { $0.id == pokemon.id }) else {
                return
            }
            try await super.delete(item: tPokemon)
        }
    }
    
    /// This function will add a specified Pokémon 'ID' and 'Favourite status' to the Database.
    /// - parameter pokemon: A 'PokemonDB' object representing the Pokémon to be added to the Database.
    @DatabaseActor
    func add(pokemon: PokemonDB) async throws {
        if let data = try await fetchData(), let _ = data.first(where: { $0.id == pokemon.id }) {
            throw DbError.recordExsist
        }
        withAnimation {
            mContext?.insert(pokemon)
        }
    }
    
    /// This function will update the Pokémon favourite status in the given Pokemon object using the record in the Database.
    /// - parameter pokemon: A 'Pokemon' object representing the Pokémon to be update.
    @DatabaseActor
    func sync(_ pokemon: inout Pokemon) async throws {
        guard let data = try await fetchData(), let _ = data.first(where: { $0.id == pokemon.id }) else {
            return pokemon.isFavorite = false
        }
        pokemon.isFavorite = true
    }
}
