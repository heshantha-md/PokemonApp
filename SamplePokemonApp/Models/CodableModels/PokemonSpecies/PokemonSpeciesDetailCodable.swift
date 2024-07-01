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
}
