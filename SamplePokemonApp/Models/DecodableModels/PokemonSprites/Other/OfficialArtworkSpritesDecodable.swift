//
//  OfficialArtworkSpritesDecodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

struct OfficialArtworkSpritesDecodable: Decodable {
    // MARK: - PROPERTIES
    var frontShiny: String?
    var backShiny: String?
    
    enum CodingKeys: String, CodingKey {
        case frontShiny = "front_shiny"
        case backShiny = "back_shiny"
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
        self.backShiny = try container.decodeIfPresent(String.self, forKey: .backShiny)
    }
    
    init(frontShiny: String? = nil, backShiny: String? = nil) {
        self.frontShiny = frontShiny
        self.backShiny = backShiny
    }
}
