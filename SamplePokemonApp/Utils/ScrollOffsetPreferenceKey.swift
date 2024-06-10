//
//  ScrollOffsetPreferenceKey.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 10/06/2024.
//

import SwiftUI

/// An object of 'ScrollOffsetPreferenceKey' will stores the scroll offset value as a preference.
struct ScrollOffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value += nextValue()
    }
}
