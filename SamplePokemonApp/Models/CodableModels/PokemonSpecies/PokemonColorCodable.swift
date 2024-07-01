//
//  PokemonColorCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import Foundation

struct PokemonColorCodable: Codable {
    // MARK: - PROPERTIES
    var name: String
    
    // MARK: - INITIALIZERS
    init(name: String) {
        self.name = name
    }
}
