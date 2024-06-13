//
//  PokemonAbilitiesDecodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

struct AbilitiesDecodable: Decodable {
    // MARK: - PROPERTIES
    var ability: AbilityDecodable
    
    enum CodingKeys: CodingKey {
        case ability
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.ability = try container.decode(AbilityDecodable.self, forKey: .ability)
    }
    
    init(ability: AbilityDecodable) {
        self.ability = ability
    }
}
