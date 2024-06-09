//
//  Pokemon.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation

struct Pokemon: Decodable {
    // MARK: - PROPERTIES
    let id: Int
    var name: String?
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
    
    init(id: Int, height: Int, sprites: Sprites) {
        self.id = id
        self.height = height
        self.sprites = sprites
    }
    
    /// This function will update 'name' property value.
    ///
    /// - parameter name: 'String' value representing Pokemon Name
    mutating func set(name: String) {
        self.name = name
    }
}

extension Pokemon: Identifiable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Pokemon: Hashable {
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}

extension Pokemon: Comparable {
    static func < (lhs: Pokemon, rhs: Pokemon) -> Bool {
        if let lname = lhs.name, let rname = rhs.name {
            return lname < rname
        }
        return lhs.id < rhs.id
    }
}


