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
    static var IC_MAGNIFYING_GLASS = Image(systemName: "magnifyingglass")
    static var IC_BACK_BUTTON = Image(systemName: "chevron.backward.square.fill")
    static var IC_HEART = Image(systemName: "heart.circle")
    static var IC_HEART_FILL = Image(systemName: "heart.circle.fill")
    static var IC_FAVORITE_UP_BUTTON = Image(systemName: "chevron.up.square.fill").resizable()
    static var IC_FAVORITE_DOWN_BUTTON = Image(systemName: "chevron.down.square.fill").resizable()
    
    struct STATS {
        static var ATTACK = Image("ic_attack").resizable().renderingMode(.template)
        static var DEFENSE = Image("ic_defense").resizable().renderingMode(.template)
        static var HP = Image("ic_hp").resizable().renderingMode(.template)
        static var SPECIAL_ATTACK = Image("ic_special_attack").resizable().renderingMode(.template)
        static var SPECIAL_DEFENSE = Image("ic_special_defense").resizable().renderingMode(.template)
        static var SPEED = Image("ic_speed").resizable().renderingMode(.template)
    }
    
    struct SCALE {
        static var CAPTURE_RATE = Image("ic_capture_rate").resizable().renderingMode(.template)
        static var HAPPINESS = Image("ic_happiness").resizable().renderingMode(.template)
        static var HEIGHT = Image("ic_height").resizable().renderingMode(.template)
        static var WEIGHT = Image("ic_weight").resizable().renderingMode(.template)
    }
}
