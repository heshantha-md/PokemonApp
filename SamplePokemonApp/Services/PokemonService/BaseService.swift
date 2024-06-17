//
//  BaseService.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 16/06/2024.
//

import Foundation
import Combine

class BaseService: ServiceProtocol {
    // MARK: - PROPERTIES
    let nwManager: NetworkManagerProtocol?
    let dbManager: DatabaseManagerProtocol?
    var cancellables: Cancellables = []
    
    // MARK: - INITIALIZERS
    /// Making default initializer function inaccessible as Network Manager Protocol (aka NetworkManagerProtocol) type object mandatory to function this class
    private init() {
        self.nwManager = nil
        self.dbManager = nil
    }
    
    required init(networkManager: NetworkManagerProtocol, databaseManager: DatabaseManagerProtocol) {
        self.nwManager = networkManager
        self.dbManager = databaseManager
    }
}
