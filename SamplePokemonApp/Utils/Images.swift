//
//  Images.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import SwiftUI

struct IMAGES {
    static let LOGO = Image("logo")
    static let DAY_BACKGROUND = Image("day_pokemon_world")
                                    .resizable()
                                    .modifier(BackgroundImageModifier())
    static let NIGHT_BACKGROUND = Image("night_pokemon_world")
                                    .resizable()
                                    .modifier(BackgroundImageModifier())
    static let IC_MAGNIFYING_GLASS = Image(systemName: "magnifyingglass")
    static let IC_BACK_BUTTON = Image(systemName: "chevron.backward.square.fill")
    static let IC_HEART = Image(systemName: "heart.circle")
    static let IC_HEART_FILL = Image(systemName: "heart.circle.fill")
    static let IC_FAVORITE_UP_BUTTON = Image(systemName: "chevron.up.square.fill").resizable()
    static let IC_FAVORITE_DOWN_BUTTON = Image(systemName: "chevron.down.square.fill").resizable()
    static let IC_POKEBALL = Image("ic_pokeball").resizable()
    
    struct STATS {
        static let ATTACK = Image("ic_attack").resizable().renderingMode(.template)
        static let DEFENSE = Image("ic_defense").resizable().renderingMode(.template)
        static let HP = Image("ic_hp").resizable().renderingMode(.template)
        static let SPECIAL_ATTACK = Image("ic_special_attack").resizable().renderingMode(.template)
        static let SPECIAL_DEFENSE = Image("ic_special_defense").resizable().renderingMode(.template)
        static let SPEED = Image("ic_speed").resizable().renderingMode(.template)
    }
    
    struct SCALE {
        static let CAPTURE_RATE = Image("ic_capture_rate").resizable().renderingMode(.template)
        static let HAPPINESS = Image("ic_happiness").resizable().renderingMode(.template)
        static let HEIGHT = Image("ic_height").resizable().renderingMode(.template)
        static let WEIGHT = Image("ic_weight").resizable().renderingMode(.template)
    }
}
