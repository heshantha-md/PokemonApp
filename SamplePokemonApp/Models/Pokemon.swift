//
//  Pokemon.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation
import SwiftUI

struct Pokemon: Decodable {
    // MARK: - PROPERTIES
    let id: Int
    var name: String
    let height: Int
    private(set) var color: PokeColor = .none
    let sprites: Sprites
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case height
        case sprites
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.height = try container.decode(Int.self, forKey: .height)
        self.sprites = try container.decode(Sprites.self, forKey: .sprites)
    }
    
    init(id: Int, name: String, color: PokeColor, height: Int, sprites: Sprites) {
        self.id = id
        self.name = name
        self.color = color
        self.height = height
        self.sprites = sprites
    }
    
    mutating func set(color: PokeColor) {
        self.color = color
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
        return lhs.id < rhs.id
    }
}


