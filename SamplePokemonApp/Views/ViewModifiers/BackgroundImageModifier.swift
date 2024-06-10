//
//  BackgroundImageModifier.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import SwiftUI

struct BackgroundImageModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .scaledToFill()
            .blur(radius: 1.5)
            .background(.black)
            .ignoresSafeArea(edges: .all)
    }
}
