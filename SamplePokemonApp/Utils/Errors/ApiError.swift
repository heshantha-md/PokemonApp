//
//  ApiError.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation

enum ApiError: LocalizedError {
    case badUrl,
         badRequest(statusCode: Int, description: String),
         dataNotFound
    
    var errorDescription: String? {
        switch self {
        case .badUrl:
            "Invalid URL"
        case .badRequest(let statusCode, let description):
            "An error occurred while requesting data (code:\(statusCode), description: \(description))"
        case .dataNotFound:
            "Coudn't not fetch the data"
        }
    }
}
