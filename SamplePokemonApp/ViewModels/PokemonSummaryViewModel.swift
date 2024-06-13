//
//  PokemonSummaryViewModel.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftUI

extension PokemonSummaryView {
    final class Model: ObservableObject {
        // MARK: - PROPERTIES
        @Published var pokemon: Binding<Pokemon>?
        private var service: PokemonService?
        
        // MARK: - INITIALIZERS
        private init() {} // Making default initializer function inaccessible as Pokemon Service (aka PokemonService) type object mandatory to function this class
        convenience init(pokemon: Binding<Pokemon>, service: PokemonService) {
            self.init()
            self.pokemon = pokemon
            self.service = service
        }
        
        // MARK: - FUNCTIONS
        /// This function will calculate the stat percentage based on base stat (aka baseStat) and maximum base stat (aka maxBaseStat)
        /// - warning: This function run on the main thread because the return value will update the UI indirectly
        /// - parameter baseStat: 'Int' type base stat (aka baseStat). "base stats" are the intrinsic values that define the potential of a Pokémon's attributes. These stats are pre-determined for each Pokémon species and remain constant regardless of the individual Pokémon
        /// - parameter maxBaseStat: 'Int' type maximum base stat (aka maxBaseStat). "maxBaseStat" typically refers to the maximum base stat value that a Pokémon can have in a particular category (HP, Attack, Defense, Special Attack, Special Defense, Speed). Each stat category has a different Pokémon species that holds the highest value for that category
        /// - returns: Will return 'Float' type stat percentage
        @MainActor
        func calculateStatPercentage(baseStat: Int, maxBaseStat: Int) -> Float {
            return (Float(baseStat) / Float(maxBaseStat)) * 100
        }
    }
}
