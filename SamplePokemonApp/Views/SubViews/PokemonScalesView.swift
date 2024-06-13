//
//  PokemonScalesView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 13/06/2024.
//

import SwiftUI

struct PokemonScalesView: View {
    // MARK: - PROPERTIES
    var pokemon: Binding<Pokemon>?
    
    // MARK: - BODY
    var body: some View {
        // MARK: - Pokémon Scales
        HStack {
            PokemonScaleView(scaleType: .capture_rate, value: pokemon?.base_happiness.wrappedValue ?? 0)
            PokemonScaleView(scaleType: .happiness, value: pokemon?.capture_rate.wrappedValue ?? 0)
            PokemonScaleView(scaleType: .weight, value: pokemon?.weight.wrappedValue ?? 0)
            PokemonScaleView(scaleType: .height, value: pokemon?.height.wrappedValue ?? 0)
        }
        .frame(maxWidth: Dimensions.isIpad ? 500 : .infinity)
    }
}

// MARK: - PREVIEW
#Preview {
    PokemonScalesView(pokemon: MocPokemon.pikachu.binding(set: { _ in }))
        .padding(.horizontal, 20)
}
