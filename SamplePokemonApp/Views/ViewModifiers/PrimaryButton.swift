//
//  PrimaryButton.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 10/06/2024.
//

import SwiftUI

struct PrimaryButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        let buttonColor = COLORS.ACTION_COLOR
        
        configuration.label
            .frame(height: 30)
            .font(.system(.subheadline, design: .monospaced, weight: .heavy))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .foregroundStyle(.white)
            .padding(.vertical, 5)
            .padding(.horizontal, 15)
            .background {
                Capsule()
                    .fill(buttonColor)
                    .overlay {
                        Capsule()
                            .stroke(.gray.opacity(0.3), lineWidth: 1)
                    }
                    .blendMode(.overlay)
                    .shadow(color: buttonColor, radius: 2, x: 1, y: 1)
                    .shadow(color: buttonColor.opacity(0.7), radius: 8, x: 2, y: 2)
            }
            .buttonStyle(.plain)
    }
}
