//
//  HomeSprites.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

struct HomeSprites: Decodable {
    // MARK: - PROPERTIES
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
        case frontShiny = "front_shiny"
        case frontShinyFemale = "front_shiny_female"
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
        self.frontFemale = try container.decodeIfPresent(String.self, forKey: .frontFemale)
        self.frontShiny = try container.decodeIfPresent(String.self, forKey: .frontShiny)
        self.frontShinyFemale = try container.decodeIfPresent(String.self, forKey: .frontShinyFemale)
    }
    
    init(frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?) {
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
    }
}
