//
//  PrimaryProgressBar.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct PrimaryProgressBar: View {
    // MARK: - PROPERTIES
    @State private var isAnimating: Bool = false
    @State var percentage: Float = 0
    var leadingColor: Color = PokeColor.yellow.actualColor
    var trailingColor: Color = PokeColor.green.actualColor
    var `height`: CGFloat = 20
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            let multiplier = geo.size.width / 100
            Group {
                ZStack(alignment: .leading) {
                    // MARK: - Background
                    RoundedRectangle(cornerRadius: height, style: .continuous)
                        .background(COLORS.PRIMARY_BG_Backward)
                        .accessibilityHidden(true)
                    
                    // MARK: - Foreground
                    RoundedRectangle(cornerRadius: height, style: .continuous)
                        .frame(width: CGFloat(percentage) * multiplier)
                        .background {
                            LinearGradient(colors: [leadingColor, trailingColor, trailingColor, trailingColor], startPoint: .leading, endPoint: .trailing)
                                .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                                .overlay {
                                    PokeColor.yellow.actualColor
                                        .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
                                        .opacity(isAnimating ? 1 : 0)
                                        .animation(.smooth(duration: 0.8).repeatForever(), value: isAnimating)
                                        .blur(radius: 10)
                                }
                        }
                }
            }
            .frame(height: 20)
            .frame(maxWidth: .infinity)
            .foregroundStyle(.clear)
            .clipShape(RoundedRectangle(cornerRadius: height, style: .continuous))
            .accessibilityElement(children: .ignore)
            .accessibilityLabel("Progress Bar")
            .accessibilityValue("\(Int(percentage))% complete")
            .accessibilityHint("Indicates the progress percentage")
        }
        .frame(maxWidth: .infinity)
        .frame(height: height)
        .animation(.spring, value: percentage)
        .onAppear {
            self.isAnimating.toggle()
        }
    }
}

// MARK: - PREVIEW
#Preview {
    ZStack(alignment: .center) {
        PrimaryProgressBar(percentage: 50)
            .padding(.horizontal, 20)
    }
    .frame(maxHeight: .infinity)
    .background(.red)
}
