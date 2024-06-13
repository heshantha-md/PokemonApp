//
//  PokemonCardBackgroundView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct PokemonCardBackgroundView: View {
    // MARK: - PROPERTIES
    var backgroundColor: Color
    
    // MARK: - BODY
    var body: some View {
        COLORS.CARD_BG_COLOR
            .background {
                backgroundColor
            }
    }
}

// MARK: - PREVIEW
#Preview {
    PokemonCardBackgroundView(backgroundColor: .yellow)
        .frame(height: 200)
        .padding(.horizontal, 20)
}
