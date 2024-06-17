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
    func delete(item: any PersistentModel) async throws
}
