//
//  Pokemon.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

struct Pokemon: Decodable {
    // MARK: - PROPERTIES
    let id: Int
    let height: Int
    let sprites: Sprites
    
    enum CodingKeys: CodingKey {
        case id
        case height
        case sprites
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.height = try container.decode(Int.self, forKey: .height)
        self.sprites = try container.decode(Sprites.self, forKey: .sprites)
    }
}
