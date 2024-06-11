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
        private init() {} // Making default initializer function inaccessible as Pokemon Service (aka PokemonService) typed object mandatory to function this class
        convenience init(pokemon: Binding<Pokemon>, service: PokemonService) {
            self.init()
            self.pokemon = pokemon
            self.service = service
        }
    }
}
