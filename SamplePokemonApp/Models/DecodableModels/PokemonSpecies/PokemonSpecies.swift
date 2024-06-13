//
//  PokemonSpecies.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

struct PokemonSpeciesDecodable: Decodable {
    // MARK: - PROPERTIES
    let name: String
    let `url`: String
    
    // MARK: - INITIALIZERS
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
