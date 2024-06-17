//
//  DbError.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 15/06/2024.
//

import Foundation

enum DbError: LocalizedError {
    case recordExsist,
         recordUpdateError(id: Int, description: String),
         dataFetchError(description: String),
         recordNotFound
    
    var errorDescription: String? {
        switch self {
        case .recordExsist:
            "Record already exist in Database"
        case .recordUpdateError(let id, let description):
            "Error when update record \(id), description: \(description)"
        case .dataFetchError(let description):
            "Error when try to fetch records from Database, description: \(description)"
        case .recordNotFound:
            "Record not found in Database"
        }
    }
}
