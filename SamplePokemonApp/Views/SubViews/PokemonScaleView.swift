//
//  PokemonScaleView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct PokemonScaleView: View {
    // MARK: - PROPERTIES
    var scaleType: PokemonScaleType
    @State var value: Int
    
    // MARK: - BODY
    var body: some View {
        HStack(spacing: 9) {
            // MARK: - Scale Icon
            Group {
                switch scaleType {
                case .happiness:
                    Image("ic_happiness").resizable().renderingMode(.template)
                        .frame(width: 19, height: 19)
                        .accessibilityHidden(true)
                case .capture_rate:
                    Image("ic_capture_rate").resizable().renderingMode(.template)
                        .accessibilityHidden(true)
                case .height:
                    Image("ic_height").resizable().renderingMode(.template)
                        .accessibilityHidden(true)
                case .weight:
                    Image("ic_weight").resizable().renderingMode(.template)
                        .frame(width: 19, height: 19)
                        .accessibilityHidden(true)
                }
            }
            .frame(width: 25, height: 25)
            .scaledToFit()
            
            // MARK: - Scale Value
            Text("\(value)")
                .lineLimit(1)
                .minimumScaleFactor(0.8)
                .accessibilityLabel("\(scaleType.description) value")
                .accessibilityValue("\(value)")
        }
        .frame(maxWidth: .infinity)
        .font(.system(.title3, design: .monospaced, weight: .bold))
        .foregroundStyle(COLORS.PRIMARY_FONT_BACKWARD)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(scaleType.description) scale")
    }
}

// MARK: - PREVIEW
#Preview {
    VStack {
        PokemonScaleView(scaleType: .happiness, value: 100)
        PokemonScaleView(scaleType: .capture_rate, value: 100)
        PokemonScaleView(scaleType: .height, value: 100)
        PokemonScaleView(scaleType: .weight, value: 100)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea()
    .background(.red)
}
