//
//  ServiceProtocol.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

import Foundation

protocol ServiceProtocol: ObservableObject {
    // MARK: - PROPERTIES
    var manager: NetworkManagerProtocal? { get }
    
    // MARK: - FUNCTIONS
    init(manager: NetworkManagerProtocal)
    func fetchData() async throws
}
