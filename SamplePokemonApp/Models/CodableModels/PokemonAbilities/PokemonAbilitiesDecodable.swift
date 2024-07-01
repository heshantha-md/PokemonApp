//
//  AbilitiesCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

struct AbilitiesCodable: Codable {
    // MARK: - PROPERTIES
    var ability: AbilityCodable
    
    // MARK: - INITIALIZERS
    init(ability: AbilityCodable) {
        self.ability = ability
    }
}
