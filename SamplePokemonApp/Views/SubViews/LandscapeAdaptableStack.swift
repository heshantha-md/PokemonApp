//
//  LandscapeAdaptableStack.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 13/06/2024.
//

import SwiftUI

struct LandscapeAdaptableStack<Content>: View where Content: View {
    // MARK: - PROPERTIES
    var content: () -> Content
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            if Dimensions.isInLandscape(width: geo.size.width, height: geo.size.height) {
                HStack {
                    self.content()
                }
            } else {
                VStack(spacing: Dimensions.isInLandscape(width: geo.size.width, height: geo.size.height) ? 0 : 22) {
                    self.content()
                }
            }
        }
    }
}
