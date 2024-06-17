//
//  PokemonSpeciesDetailDecodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import Foundation

struct PokemonSpeciesDetailDecodable: Decodable {
    // MARK: - PROPERTIES
    var base_happiness: Int
    var capture_rate: Int
    var color: PokemonColorDecodable
    
    enum CodingKeys: CodingKey {
        case base_happiness
        case capture_rate
        case color
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.base_happiness = try container.decode(Int.self, forKey: .base_happiness)
        self.capture_rate = try container.decode(Int.self, forKey: .capture_rate)
        self.color = try container.decode(PokemonColorDecodable.self, forKey: .color)
    }
    
    init(base_happiness: Int, capture_rate: Int, color: PokemonColorDecodable) {
        self.base_happiness = base_happiness
        self.capture_rate = capture_rate
        self.color = color
    }
}
