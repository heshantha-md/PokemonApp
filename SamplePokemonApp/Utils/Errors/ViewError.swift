//
//  ViewError.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 13/06/2024.
//

import Foundation

enum ViewError: LocalizedError, Equatable {
    case badPokemonFetchDataResponse(error: String),
         badResponseForSearchPokemonFromService(error: String),
         failedToMakePokemonFavorite
    
    var errorDescription: String? {
        switch self {
        case .badPokemonFetchDataResponse(let error):
            "Bad Response Error: \(error)"
        case .badResponseForSearchPokemonFromService(let error):
            "Bad Response Error: \(error)"
        case .failedToMakePokemonFavorite:
            "Sorry, the attempt to make Pokémon a favorite failed. Please try again."
        }
    }
}
