//
//  NetworkManagerProtocal.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation

protocol NetworkManagerProtocal {
    // MARK: - FUNCTIONS
    func fetch<T: Decodable>(_ endpoint: ApiEndPoint) async throws -> T?
    func decode<T: Decodable>(_ data: Data) throws -> T?
}
