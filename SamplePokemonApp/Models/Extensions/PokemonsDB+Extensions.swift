//
//  PokemonsDB+Extensions.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftData

extension PokemonsDB {
    @MainActor
    func sync(with pokemons: Pokemons, in model: ModelContext) async {
        pokemons.forEach { pokemon in
            if let productDB = self.first(where: { $0.id == pokemon.id }) {
                productDB.update(using: pokemon)
            } else {
                model.insert(pokemon.asPokemonDB)
            }
        }
    }
}

extension Pokemons {
    @MainActor
    var asPokemonsDB: PokemonsDB {
        self.map { $0.asPokemonDB }
    }
}

extension PokemonsDB {
    @MainActor
    var asPokemons: Pokemons {
        Set(self.map { $0.asPokemon })
    }
}
