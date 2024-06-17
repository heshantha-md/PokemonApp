//
//  MocPokemonDatabaseManager.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 17/06/2024.
//

import Foundation
import SwiftData

final class MocPokemonDatabaseManager: BaseDatabaseManager {
    // MARK: - PROPERTIES
    var favoriteDB: Set<PokemonDB> = []
    var failAddFavorite: Bool = false
    var failDeleteFavorite: Bool = false
    
    // MARK: - FUNCTIONS
    /// This function will add a specified Pokémon 'ID' and 'Favourite status' to the Database.
    /// - parameter pokemon: A 'PokemonDB' object representing the Pokémon to be added to the Database.
    func add(pokemon: PokemonDB) async throws {
        if !failAddFavorite {
            favoriteDB.insert(PokemonDB(id: pokemon.id))
        }
    }
    
    /// This function will delete a given Persistent Model (aka PersistentModel) in the Database
    /// - parameter item: A PersistentModel of any Persistent Model object.
    override func delete(item: any PersistentModel) async throws {
        if let pokemon = item as? PokemonDB, !failDeleteFavorite {
            favoriteDB.remove(PokemonDB(id: pokemon.id))
        }
    }
    
    /// This function will update the Pokémon favourite status in the given Pokemon object using the record in the Database.
    /// - parameter pokemon: A 'Pokemon' object representing the Pokémon to be update.
    func sync(_ pokemon: inout Pokemon) async throws {
        guard let _ = favoriteDB.first(where: { $0.id == pokemon.id }) else {
            return pokemon.isFavorite = false
        }
        pokemon.isFavorite = true
    }
}
