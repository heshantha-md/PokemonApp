//
//  Dimensions.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct Dimensions {
    static let SCREEN_HEIGHT = UIScreen.main.bounds.height
    static let SCREEN_WIDTH = UIScreen.main.bounds.width
    static let isIphoneSE = Dimensions.SCREEN_HEIGHT <= 667
    static let isIphone = UIDevice.current.model == "iPhone"
    static let isIpad = UIDevice.current.model == "iPad"
}
