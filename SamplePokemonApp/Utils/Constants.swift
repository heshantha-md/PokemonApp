//
//  Constants.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

struct Constants {
    struct URLS {
        static let POKEMONS_BASE_URL = "https://pokeapi.co/api/v2"
        static let DEFAULT_LIMIT = Dimensions.isIpad ? 30 : 20
        static let FAVORITE_DEFAULT_LIMIT = Dimensions.isIpad ? 15 : 10
    }
    
    static let POKEMONS_NAME = "Pokémon's Name"
    static let CANCEL = "Cancel"
    static let SEARCH = "Search"
    static let FRONT = "Front"
    static let BACK = "Back"
    static let CHANGE_SIDE = "Change Side"
    static let ERROR = "ERROR"
    static let OK = "OK"
    
    struct STATS {
        static let HP = "HP"
        static let ATTACK = "Attack"
        static let DEFENSE = "Defense"
        static let SPECIAL_ATTACK = "Special Attack"
        static let SPECIAL_DEFENSE = "Special Defense"
        static let SPEED = "Speed"
    }
    
    struct TITLES {
        static let FAVOURITE = "Favorite Pokémon"
    }
}
