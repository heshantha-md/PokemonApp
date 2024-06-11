//
//  PokemonSummaryView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftUI

struct PokemonSummaryView: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel: Model
    
    init(model: Model) {
        _viewModel = StateObject(wrappedValue: model)
    }
    
    // MARK: - BODY
    var body: some View {
        Text(viewModel.pokemon?.name.wrappedValue ?? "N/A")
    }
}

#Preview {
    PokemonSummaryView(model: PokemonSummaryView.Model(pokemon: .constant(MocPokemon.pikachu), service: PokemonService(manager: MocNetworkManager())))
}
