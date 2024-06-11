//
//  SimpleButton.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 10/06/2024.
//

import SwiftUI

struct SimpleButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 60, maxWidth: .infinity)
            .frame(height: 40)
            .font(.system(.subheadline, design: .monospaced, weight: .heavy))
            .lineLimit(1)
            .minimumScaleFactor(0.5)
            .padding(.horizontal, 5)
            .buttonStyle(.plain)
    }
}
