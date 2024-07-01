//
//  PokemonSpeciesDetailCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import Foundation

struct PokemonSpeciesDetailCodable: Codable {
    // MARK: - PROPERTIES
    var base_happiness: Int
    var capture_rate: Int
    var color: PokemonColorCodable
    
    // MARK: - INITIALIZERS
    init(base_happiness: Int, capture_rate: Int, color: PokemonColorCodable) {
        self.base_happiness = base_happiness
        self.capture_rate = capture_rate
        self.color = color
    }
}
