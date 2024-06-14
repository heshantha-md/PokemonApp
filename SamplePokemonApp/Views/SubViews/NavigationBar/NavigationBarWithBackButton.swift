//
//  NavigationBarWithBackButton.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 14/06/2024.
//

import SwiftUI

struct NavigationBarWithBackButton: View {
    // MARK: - PROPERTIES
    var action: (() -> ())? = nil
    
    // MARK: - BODY
    var body: some View {
        Button { action?() } label: {
            IMAGES.IC_BACK_BUTTON
                .font(.largeTitle)
        }
        .frame(width: 70, height: 50)
        .buttonStyle(SimpleButton())
        .foregroundStyle(COLORS.PRIMARY_FONT_BACKWARD)
        .offset(y: Dimensions.isIphoneSE ? 40 : 70)
    }
}

// MARK: - PREVIEW
#Preview {
    NavigationBarWithBackButton(action: {})
}
