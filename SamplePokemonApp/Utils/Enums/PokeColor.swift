//
//  PokeColor.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftUI

enum PokeColor: String {
    // MARK: - PROPERTIES
    case black = "black"
    case blue = "blue"
    case brown = "brown"
    case gray = "gray"
    case green = "green"
    case pink = "pink"
    case purple = "purple"
    case red = "red"
    case white = "white"
    case yellow = "yellow"
    case none = "none"
    
    var color: Color {
        self == .none ? .clear : Color("poke\(self.rawValue)")
    }
    
    // MARK: - FUNCTIONS
    static func pokemonColor(by name: String) -> PokeColor {
        switch name {
        case "black": .black
        case "blue": .blue
        case "brown": .brown
        case "gray": .gray
        case "green": .green
        case "pink": .pink
        case "purple": .purple
        case "red": .red
        case "white": .white
        case "yellow": .yellow
        default: .none
        }
    }
}
