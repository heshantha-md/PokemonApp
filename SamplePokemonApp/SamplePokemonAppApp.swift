//
//  SamplePokemonAppApp.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import SwiftUI

@main
struct SamplePokemonAppApp: App {
    // MARK: - BODY
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                HomeView(model: HomeView.Model(service: PokemonService(manager: NetworkManager())))
            }
        }
    }
}
