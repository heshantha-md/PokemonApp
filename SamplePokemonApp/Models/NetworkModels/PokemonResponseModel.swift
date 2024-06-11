//
//  PokemonResponseModel.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

struct PokemonResponseModel: Decodable {
    // MARK: - PROPERTIES
    let name: String
    let url: String
    
    init(name: String, url: String) {
        self.name = name
        self.url = url
    }
}
