//
//  PokemonStatDecodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

struct StatDecodable: Decodable {
    // MARK: - PROPERTIES
    var name: String
    
    enum CodingKeys: CodingKey {
        case name
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
    }
    
    init(name: String) {
        self.name = name
    }
}
