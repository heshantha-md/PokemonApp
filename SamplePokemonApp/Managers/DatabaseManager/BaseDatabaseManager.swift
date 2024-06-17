//
//  BaseDatabaseManager.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 16/06/2024.
//

import SwiftUI
import SwiftData

class BaseDatabaseManager: DatabaseManagerProtocol {
    // MARK: - PROPERTIES
    var mContext: ModelContext?
    
    // MARK: - INITIALIZERS
    init() { }
    init(context: ModelContainer) {
        self.mContext = ModelContext(context)
    }
    
    /// This function will delete list of given Persistent Models (aka PersistentModel) in the Database
    /// - parameter items: An array of any Persistent Model objects.
    @DatabaseActor
    func delete(items: [any PersistentModel]) async throws {
        Task(priority: .userInitiated) {
            items.forEach { item in
                withAnimation {
                    mContext?.delete(item)
                }
            }
        }
    }
}
