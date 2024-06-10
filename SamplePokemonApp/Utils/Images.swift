//
//  Images.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import SwiftUI

struct IMAGES {
    static var LOGO = Image("logo")
    static var DAY_BACKGROUND = Image("day_pokemon_world")
                                    .resizable()
                                    .modifier(BackgroundImageModifier())
    static var NIGHT_BACKGROUND = Image("night_pokemon_world")
                                    .resizable()
                                    .modifier(BackgroundImageModifier())
    static var MAGNIFYING_GLASS_ICON = Image(systemName: "magnifyingglass.circle.fill")
}
