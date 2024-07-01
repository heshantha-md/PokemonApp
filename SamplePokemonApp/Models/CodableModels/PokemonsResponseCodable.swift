//
//  PokemonsResponseCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

struct PokemonsResponseCodable: Codable {
    // MARK: - PROPERTIES
    let count: Int
    let results: [PokemonResponseCodable]
    
    // MARK: - INITIALIZERS
    init(count: Int, results: [PokemonResponseCodable]) {
        self.count = count
        self.results = results
    }
}
