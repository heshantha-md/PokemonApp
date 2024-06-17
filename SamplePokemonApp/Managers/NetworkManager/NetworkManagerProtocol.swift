//
//  NetworkManagerProtocol.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation

@globalActor actor NetworkActor: GlobalActor {
    static let shared = NetworkActor()
}

protocol NetworkManagerProtocol {
    // MARK: - FUNCTIONS
    func fetchData<T: Decodable>(_ endpoint: ApiEndPoint) async throws -> T?
}
