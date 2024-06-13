//
//  ViewError.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 13/06/2024.
//

import Foundation

enum ViewError: LocalizedError, Equatable {
    case badPokemonFetchDataResponse(error: String)
    case badResponseForSearchPokemonFromService(error: String)
    
    var errorDescription: String? {
        switch self {
        case .badPokemonFetchDataResponse(let error):
            "Bad Response Error: \(error)"
        case .badResponseForSearchPokemonFromService(let error):
            "Bad Response Error: \(error)"
        }
    }
}
