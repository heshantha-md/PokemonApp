//
//  AbilityCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

struct AbilityCodable: Codable {
    // MARK: - PROPERTIES
    var name: String
    
    // MARK: - INITIALIZERS
    init(name: String) {
        self.name = name
    }
}
