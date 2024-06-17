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
    
    /// This function will delete a given Persistent Model (aka PersistentModel) in the Database
    /// - parameter item: A PersistentModel of any Persistent Model object.
    @DatabaseActor
    func delete(item: any PersistentModel) async throws {
        Task(priority: .userInitiated) {
            withAnimation {
                mContext?.delete(item)
            }
        }
    }
}
