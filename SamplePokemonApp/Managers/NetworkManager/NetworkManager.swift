//
//  NetworkManager.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation

final class NetworkManager: NetworkManagerProtocol {
    /// Generic API call function to fetch and decode data
    ///
    /// - parameter endpoint: Api endpoint information
    /// - returns: Generic type representation of the results
    @NetworkActor
    func fetchData<T>(_ endpoint: ApiEndPoint) async throws -> T? where T : Decodable {
        guard let url = URL(string: endpoint.url) else { throw ApiError.badUrl }
        
        var request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad)
        request.httpMethod = endpoint.method.rawValue
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let response = (response as? HTTPURLResponse), response.statusCode != 200 {
            throw ApiError.badRequest(statusCode: response.statusCode, description: response.description)
        }
        return try decode(data)
    }
    
    /// Generic Decodable type function to decode data
    ///
    /// - parameter data: Data need to be decode
    /// - returns: Generic type representation of the data
    @NetworkActor
    func decode<T>(_ data: Data) throws -> T? where T : Decodable {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
