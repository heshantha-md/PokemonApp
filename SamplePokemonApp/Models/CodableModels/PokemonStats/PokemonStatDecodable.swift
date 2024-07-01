//
//  StatCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

struct StatCodable: Codable {
    // MARK: - PROPERTIES
    var name: String
    
    // MARK: - INITIALIZERS
    init(name: String) {
        self.name = name
    }
}
