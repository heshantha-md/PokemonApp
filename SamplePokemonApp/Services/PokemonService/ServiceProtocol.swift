//
//  ServiceProtocol.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

import Foundation

protocol ServiceProtocol: ObservableObject {
    // MARK: - PROPERTIES
    var nwManager: NetworkManagerProtocol? { get }
    var dbManager: DatabaseManagerProtocol? { get }
    
    // MARK: - FUNCTIONS
    init(networkManager: NetworkManagerProtocol, 
         databaseManager: DatabaseManagerProtocol)
}
