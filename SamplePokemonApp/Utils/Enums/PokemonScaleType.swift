//
//  PokemonScaleType.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

enum PokemonScaleType {
    case happiness
    case capture_rate
    case `height`
    case weight
    
    var description: String {
        switch self {
        case .happiness:
            return "Happiness"
        case .capture_rate:
            return "Capture rate"
        case .height:
            return "Height"
        case .weight:
            return "Weight"
        }
    }
}
