//
//  OfficialArtworkSpritesCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

struct OfficialArtworkSpritesCodable: Codable {
    // MARK: - PROPERTIES
    var frontShiny: String?
    var backShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontShiny = "front_shiny"
        case backShiny = "back_shiny"
    }
    
    // MARK: - ENCODING
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(frontShiny, forKey: .frontShiny)
        try container.encode(backShiny, forKey: .backShiny)
    }
    
    // MARK: - DECODING
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
        self.backShiny = try container.decodeIfPresent(String.self, forKey: .backShiny)
    }
    
    // MARK: - INITIALIZERS
    init(frontShiny: String? = nil, backShiny: String? = nil) {
        self.frontShiny = frontShiny
        self.backShiny = backShiny
    }
}
