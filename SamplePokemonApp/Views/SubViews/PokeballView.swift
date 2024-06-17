//
//  PokeballView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct PokeballView: View {
    // MARK: - PROPERTIES
    var pokemon: Binding<Pokemon>?
    @State private var isPokemonBackSide: Bool = false
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            HStack(spacing: 10) {
                VStack {
                    // MARK: - Pokémon Sprite GIF
                    Group {
                        if isPokemonBackSide == true {
                            if let stringUrl = pokemon?.sprites.showdown.backShiny.wrappedValue, let url = URL(string: stringUrl) {
                                CacheAnimatedImageView(url: url)
                                    .accessibilityLabel("Back Sprite of \(pokemon?.name.wrappedValue ?? "Pokémon")")
                            }
                        } else {
                            if let stringUrl = pokemon?.sprites.showdown.frontShiny.wrappedValue, let url = URL(string: stringUrl) {
                                CacheAnimatedImageView(url: url)
                                    .accessibilityLabel("Front Sprite of \(pokemon?.name.wrappedValue ?? "Pokémon")")
                            }
                        }
                    }
                }
                
                // MARK: - Change Side Buttons
                Button { changePokemonSide() } label: {
                    Text(Constants.CHANGE_SIDE.uppercased())
                }
                .modifier(LabelButton(backgroundColor: COLORS.ACTION_COLOR,
                                      foregroundColor: .white))
                .accessibilityLabel("Change Pokemon Sides")
                .accessibilityHint("Tap to see the front and back sides of the Animated Pokémon")
                .accessibilityValue(isPokemonBackSide ? "Inactive" : "Active")
                .animation(.linear, value: isPokemonBackSide)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .accessibilityElement(children: .combine)
            .accessibilityLabel("Animated Pokémon Sprite View")
            .accessibilityHint("Displays the front or back animated sprite of the Pokémon with toggle buttons")
        }
    }
    
    // MARK: - FUNCTIONS
    /// This function will change the Pokémon's direction (Front, Back) inside the ball
    private func changePokemonSide() {
        withAnimation(.easeInOut(duration: 0.5)) {
            isPokemonBackSide.toggle()
        }
    }
}

// MARK: - PREVIEW
#Preview {
    GeometryReader { geo in
        ZStack {
            PokeballView(pokemon: MocPokemon.pikachu.binding(set: { _ in }))
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
}
