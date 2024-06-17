//
//  Pokemon.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

final class Pokemon: ObservableObject {
    // MARK: - PROPERTIES
    let id: Int
    var name: String
    var height: Int
    var weight: Int
    var species: Species
    var sprites: Sprites
    var abilities: [Ability]
    var stat: Stat
    var base_happiness: Int = 0
    var capture_rate: Int = 0
    var color: PokeColor = .none
    @Published var isFavorite: Bool {
        didSet {
            objectWillChange.send()
        }
    }
    
    // MARK: - INITIALIZERS
    init(id: Int, name: String, height: Int, weight: Int, species: Species, sprites: Sprites, abilities: [Ability], stat: Stat, base_happiness: Int = 0, capture_rate: Int = 0, color: PokeColor = .none, isFavorite: Bool = false) {
        self.id = id
        self.name = name
        self.height = height
        self.weight = weight
        self.species = species
        self.sprites = sprites
        self.abilities = abilities
        self.stat = stat
        self.base_happiness = base_happiness
        self.capture_rate = capture_rate
        self.color = color
        self.isFavorite = isFavorite
    }
    
    // MARK: - FUNCTIONS
    func set(base_happiness: Int, capture_rate: Int, color: PokeColor) {
        self.base_happiness = base_happiness
        self.capture_rate = capture_rate
        self.color = color
    }
}

extension Pokemon: Identifiable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}

extension Pokemon: Hashable {
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}

extension Pokemon: Comparable {
    static func < (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id < rhs.id
    }
}

extension Pokemon {
    func binding(set: @escaping (Pokemon)->()) -> Binding<Pokemon> {
        Binding<Pokemon>(get: { self }, set: { set($0) } )
    }
}
