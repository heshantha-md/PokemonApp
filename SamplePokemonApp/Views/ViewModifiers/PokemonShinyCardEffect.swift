//
//  PokemonShinyCardEffect.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct PokemonShinyCardEffect: ViewModifier {
    // MARK: - PROPERTIES
    @Binding var isAnimating: Bool
    
    // MARK: - BODY
    func body(content: Content) -> some View {
        content
            .overlay {
                // MARK: - Card Shiny Effect
                LinearGradient(colors: COLORS.SHINY_WHITE, startPoint: .bottomTrailing, endPoint: .topLeading)
                    .offset(x: isAnimating ? 100 : -100, y: -80)
                    .rotationEffect(Angle(degrees: 60), anchor: .topLeading)
                    .scaleEffect(3)
            }
    }
}
