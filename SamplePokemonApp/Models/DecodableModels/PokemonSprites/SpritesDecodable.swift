//
//  PokemonSpritesDecodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

struct SpritesDecodable: Decodable {
    // MARK: - PROPERTIES
    var other: OtherSpritesDecodable
    
    enum CodingKeys: String, CodingKey {
        case other
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.other = try container.decode(OtherSpritesDecodable.self, forKey: .other)
    }
    
    init(other: OtherSpritesDecodable) {
        self.other = other
    }
}
