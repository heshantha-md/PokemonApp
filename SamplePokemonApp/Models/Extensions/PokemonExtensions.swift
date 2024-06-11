//
//  PokemonExtensions.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

extension Pokemons {
    /// This function will sort the Pokémon list in ascending order by it's name
    /// - warning: This function run on the main thread because 'pokemons' properties are published and will update the UI by it's observers.
    /// - returns: 'Array' typed Pokémon's list (aka PokemonsArr)
    @MainActor
    func sorted() -> PokemonsArr {
        Array(self).sorted(by: <)
    }
}
