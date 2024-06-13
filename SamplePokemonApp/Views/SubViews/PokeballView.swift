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
            HStack(spacing: 15) {
                VStack {
                    // MARK: - Pokémon Sprite GIF
                    Group {
                        if isPokemonBackSide == true {
                            if let stringUrl = pokemon?.sprites.showdown.backShiny.wrappedValue, let url = URL(string: stringUrl) {
                                CacheAnimatedImageView(url: url)
                            }
                        } else {
                            if let stringUrl = pokemon?.sprites.showdown.frontShiny.wrappedValue, let url = URL(string: stringUrl) {
                                CacheAnimatedImageView(url: url)
                            }
                        }
                    }
                }
                
                HStack(spacing: 10) {
                    // MARK: - Front & Back Buttons
                    Group {
                        Button { changePokemonSide() } label: {
                            Text(Constants.FRONT.uppercased())
                        }
                        .modifier(LabelButton(backgroundColor: isPokemonBackSide ? .black : .red,
                                              foregroundColor: .white))
                        
                        Button { changePokemonSide() } label: {
                            Text(Constants.BACK.uppercased())
                        }
                        .modifier(LabelButton(backgroundColor: isPokemonBackSide ? .red : .black,
                                              foregroundColor: .white))
                    }
                    .animation(.linear, value: isPokemonBackSide)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
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
