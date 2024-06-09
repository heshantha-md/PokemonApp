//
//  NetworkManagerProtocal.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation

protocol NetworkManagerProtocal {
    // MARK: - FUNCTIONS
    func fetchData<T: Decodable>(_ endpoint: ApiEndPoint) async throws -> T?
}
