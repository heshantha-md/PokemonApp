//
//  Pokemon.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct Pokemon {
    // MARK: - PROPERTIES
    let `id`: Int
    var name: String
    var `height`: Int
    var weight: Int
    var species: Species
    var sprites: Sprites
    var abilities: [Ability]
    var stat: Stat
    var base_happiness: Int = 0
    var capture_rate: Int = 0
    var color: PokeColor = .none
    
    // MARK: - INITIALIZERS
    init(id: Int, name: String, height: Int, weight: Int, species: Species, sprites: Sprites, abilities: [Ability], stat: Stat, base_happiness: Int = 0, capture_rate: Int = 0, color: PokeColor = .none) {
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
    }
    
    // MARK: - FUNCTIONS
    mutating func set(base_happiness: Int, capture_rate: Int, color: PokeColor) {
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

extension Pokemons {
    /// This function will sort the Pokémon list in ascending order by it's name
    /// - warning: This function run on the main thread because 'pokemons' properties are published and will update the UI by it's observers.
    /// - returns: 'Array' type Pokémon's list (aka PokemonsArr)
    @MainActor
    func sorted() -> PokemonsArr {
        Array(self).sorted(by: <)
    }
}

