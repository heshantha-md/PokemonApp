//
//  PokemonSpecies.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import Foundation

struct PokemonSpecies: Decodable {
    // MARK: - PROPERTIES
    let base_happiness: Int
    let capture_rate: Int
    let `color`: PokemonColor
    
    enum CodingKeys: CodingKey {
        case base_happiness
        case capture_rate
        case color
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.base_happiness = try container.decode(Int.self, forKey: .base_happiness)
        self.capture_rate = try container.decode(Int.self, forKey: .capture_rate)
        self.color = try container.decode(PokemonColor.self, forKey: .color)
    }
}
