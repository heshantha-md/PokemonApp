//
//  OfficialArtworkSprites.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

struct OfficialArtworkSprites: Decodable {
    // MARK: - PROPERTIES
    let frontShiny: String?
    let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
        self.frontShinyFemale = try container.decodeIfPresent(String.self, forKey: .frontShinyFemale)
    }
}
