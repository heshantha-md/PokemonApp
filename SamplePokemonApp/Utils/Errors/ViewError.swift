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
         failedToMakePokemonFavorite,
         failedToRemovePokemonFromFavorite,
         failedToFetchPokemonFavorites
    
    var errorDescription: String? {
        switch self {
        case .badPokemonFetchDataResponse(let error):
            "Bad Response Error: \(error)"
        case .badResponseForSearchPokemonFromService(let error):
            "Bad Response Error: \(error)"
        case .failedToMakePokemonFavorite:
            "Sorry, the attempt to make the Pokémon a favorite failed. Please try again."
        case .failedToRemovePokemonFromFavorite:
            "Sorry, the attempt to remove the Pokémon from favorites failed. Please try again."
        case .failedToFetchPokemonFavorites:
            "Sorry, the attempt to fetch your favorite Pokémon has failed."
        }
    }
}
