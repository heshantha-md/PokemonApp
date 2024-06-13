//
//  LabelButton.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct LabelButton: ViewModifier {
    var backgroundColor: Color = .black
    var foregroundColor: Color = .white
    
    func body(content: Content) -> some View {
        content
            .font(.system(.subheadline, design: .monospaced, weight: .heavy))
            .foregroundStyle(foregroundColor)
            .padding(.horizontal, 13)
            .padding(.vertical, 8)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}
