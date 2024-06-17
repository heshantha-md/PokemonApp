//
//  PokemonsArr+Extensions.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 17/06/2024.
//

extension PokemonsArr {
    var favorites: PokemonsArr {
        self.filter { $0.isFavorite }
    }
}
