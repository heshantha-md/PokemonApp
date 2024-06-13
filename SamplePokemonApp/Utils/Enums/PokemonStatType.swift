//
//  PokemonStatType.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

enum StatType: String {
    case hp
    case attack
    case defense
    case specialAttack
    case specialDefense
    case speed
    
    var max: Int {
        switch self {
        case .hp: 255
        case .attack: 190
        case .defense: 230
        case .specialAttack: 194
        case .specialDefense: 230
        case .speed: 200
        }
    }
}
