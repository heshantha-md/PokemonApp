//
//  DreamWorldSprites.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

struct DreamWorldSprites: Decodable {
    // MARK: - PROPERTIES
    let frontDefault: String?
    let frontFemale: String?
    
    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
        case frontFemale = "front_female"
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.frontDefault = try container.decodeIfPresent(String.self, forKey: .frontDefault)
        self.frontFemale = try container.decodeIfPresent(String.self, forKey: .frontFemale)
    }
    
    init(frontDefault: String?, frontFemale: String?) {
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
    }
}
