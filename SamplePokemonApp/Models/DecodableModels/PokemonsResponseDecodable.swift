//
//  PokemonsResultsModel.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

struct PokemonsResponseDecodable: Decodable {
    // MARK: - PROPERTIES
    let `count`: Int
    let results: [PokemonResponseDecodable]
    
    enum CodingKeys: CodingKey {
        case count
        case results
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.count = try container.decode(Int.self, forKey: .count)
        self.results = try container.decode([PokemonResponseDecodable].self, forKey: .results)
    }
    
    init(count: Int, results: [PokemonResponseDecodable]) {
        self.count = count
        self.results = results
    }
}
