//
//  Stat.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

struct Stat {
    // MARK: - PROPERTIES
    var hp: Int
    var attack: Int
    var defense: Int
    var specialAttack: Int
    var specialDefense: Int
    var speed: Int
    
    // MARK: - INITIALIZERS
    init(hp: Int, attack: Int, defense: Int, specialAttack: Int, specialDefense: Int, speed: Int) {
        self.hp = hp
        self.attack = attack
        self.defense = defense
        self.specialAttack = specialAttack
        self.specialDefense = specialDefense
        self.speed = speed
    }
}
