//
//  ServiceProtocol.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

import Foundation

protocol ServiceProtocol: ObservableObject {
    // MARK: - PROPERTIES
    var manager: NetworkManagerProtocal? { set get }
    
    // MARK: - FUNCTIONS
    init(manager: NetworkManagerProtocal)
    func fetch() async throws
}
