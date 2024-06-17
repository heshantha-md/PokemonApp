//
//  Pokemon.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI
import SwiftData

@Model
final class PokemonDB {
    // MARK: - PROPERTIES
    @Attribute(.unique) let id: Int
    
    // MARK: - INITIALIZERS
    init(id: Int) {
        self.id = id
    }
}

