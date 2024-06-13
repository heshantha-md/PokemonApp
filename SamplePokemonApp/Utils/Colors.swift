//
//  Colors.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import SwiftUI

struct COLORS {
    static let SHINY_WHITE: [Color] = [.clear, .clear, .white.opacity(0.5), .clear, .clear]
    static let PRIMARY_FONT: Color = Color("PrimaryFontColor")
    static let PRIMARY_FONT_BACKWARD: Color = Color("PrimaryFontColorBackward")
    static let PRIMARY_BG: Color = Color("PrimaryBGColor")
    static let PRIMARY_BG_Backward: Color = Color("PrimaryBGColorBackward")
    static let SECONDARY_FONT_COLOR: Color = Color("SecondaryFontColor")
    static let CARD_BG_COLOR: LinearGradient = LinearGradient(colors: COLORS.SHINY_WHITE, startPoint: .topLeading, endPoint: .bottomTrailing)
}
