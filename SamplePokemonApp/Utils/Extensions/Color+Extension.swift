//
//  Color+Extension.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import SwiftUI

extension Color {
    static func pokemonColor(by name: String) -> Color {
        return Color("Poke\(name.uppercased())")
    }
}
