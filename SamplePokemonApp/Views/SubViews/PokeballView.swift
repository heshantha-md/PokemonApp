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
    @State var mainGeo: GeometryProxy
    
    // MARK: - BODY
    var body: some View {
        ZStack {
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
            .scaledToFill()
        }
        .frame(width: (mainGeo.size.height / 6.5), height: (mainGeo.size.height / 6.5))
        .padding((mainGeo.size.height / 30))
        .background(.white)
        .clipShape(Circle())
        .overlay(Circle().stroke(.red, lineWidth: 8))
        .overlay(alignment: .center) {
            HStack(spacing: 10) {
                // MARK: - Front & Back Buttons
                Group {
                    Button { changePokemonSide() } label: {
                        Text(Constants.FRONT)
                    }
                    .modifier(LabelButton(backgroundColor: isPokemonBackSide ? .black : .red,
                                          foregroundColor: .white))
                    
                    Button { changePokemonSide() } label: {
                        Text(Constants.BACK)
                    }
                    .modifier(LabelButton(backgroundColor: isPokemonBackSide ? .red : .black,
                                          foregroundColor: .white))
                }
                .animation(.linear, value: isPokemonBackSide)
            }
            .offset(x: (mainGeo.size.height / 6.5) + 60, y: -25)
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
            PokeballView(pokemon: MocPokemon.pikachu.binding(set: { _ in }),
                                 mainGeo: geo)
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
    }
    
}
