//
//  ApiEndPoint.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

/// ApiEndPoint type to support Network Managers, which will contain API endpoint information.
@NetworkActor
enum ApiEndPoint {
    case getPokemons(offset: Int)
    case getPokemonByName(_ name: String)
    case getPokemonById(_ id: Int)
    case getFrom(url: String)
    
    /// Different types of HTTP Methods
    enum Method: String {
        case GET
    }
}

@NetworkActor
extension ApiEndPoint {
    // MARK: - url
    var url: String {
        switch self {
        case .getPokemons(let offset):
            Constants.URLS.POKEMONS_BASE_URL + "/pokemon/?offset=\(offset)&limit=\(self.limit ?? Constants.URLS.DEFAULT_LIMIT)"
        case .getPokemonByName(let name):
            Constants.URLS.POKEMONS_BASE_URL + "/pokemon/\(name.lowercased().replacingOccurrences(of: " ", with: "-"))"
        case .getPokemonById(let id):
            Constants.URLS.POKEMONS_BASE_URL + "/pokemon/\(id)"
        case .getFrom(let url):
            url
        }
    }
   
    // MARK: - method
    var method: ApiEndPoint.Method {
        switch self {
        default: .GET
        }
    }
    
    // MARK: - limit
    var limit: Int? {
        switch self {
        case .getPokemons(_): Constants.URLS.DEFAULT_LIMIT
        default: nil
        }
    }
}
