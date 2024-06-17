//
//  DatabaseManagerProtocol.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 15/06/2024.
//

import SwiftUI
import SwiftData

@globalActor actor DatabaseActor: GlobalActor {
    static let shared = DatabaseActor()
}

protocol DatabaseManagerProtocol {
    // MARK: - PROPERTIES
    var mContext: ModelContext? { get }
    
    // MARK: - FUNCTIONS
    func delete(items: [any PersistentModel]) async throws
}
