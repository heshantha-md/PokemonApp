//
//  PokemonResponseModel.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

struct PokemonResponseDecodable: Decodable {
    // MARK: - PROPERTIES
    let name: String
    let `url`: String
    
    // MARK: - INITIALIZERS
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
