//
//  ApiEndPoint.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

/// ApiEndPoint type to support Network Managers, which will contain API endpoint information.
enum ApiEndPoint {
    case getPokemons(offset: Int)
    case getPokemon(name: String)
    case getPokemonSpecies(id: Int)
    
    /// Different types of HTTP Methods
    enum Method: String {
        case GET
    }
}

extension ApiEndPoint {
    // MARK: - url
    var url: String {
        switch self {
        case .getPokemons(let offset):
            return Constants.URLS.POKEMONS_BASE_URL + "/pokemon/?offset=\(offset)&limit=\(self.limit ?? Constants.URLS.DEFAULT_LIMIT)"
        case .getPokemon(name: let name):
            return Constants.URLS.POKEMONS_BASE_URL + "/pokemon/\(name)"
        case .getPokemonSpecies(id: let id):
            return Constants.URLS.POKEMONS_BASE_URL + "/pokemon-species/\(id)"
        }
    }
   
    // MARK: - method
    var method: ApiEndPoint.Method {
        switch self {
        default:
            return .GET
        }
    }
    
    // MARK: - limit
    var limit: Int? {
        switch self {
        case .getPokemons(_):
            return 20
        default: return nil
        }
    }
}