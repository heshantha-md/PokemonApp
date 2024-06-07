//
//  ServiceProtocol.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

protocol ServiceProtocol {
    // MARK: - PROPERTIES
    var manager: NetworkManagerProtocal { set get }
    
    // MARK: - FUNCTIONS
    init(manager: NetworkManagerProtocal)
    func fetch() async throws
}
