//
//  PrimaryCollectionCellView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 09/06/2024.
//

import SwiftUI
import Kingfisher

struct PrimaryCollectionCellView: View {
    // MARK: - PROPERTIES
    @Binding var pokemon: Pokemon
    @State private var isAnimating: Bool = false
    
    // MARK: - BODY
    var body: some View {
        // MARK: - Pokémon Color
        let pokemonColor = pokemon.color.actualColor
        
        ZStack {
            // MARK: - Sprite Image
            if let stringUrl = pokemon.sprites.officialArtwork.frontShiny,
               let url = URL(string: stringUrl) {
                KFImage(url)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onSuccess { result in
                        DispatchQueue.main.async {
                            withAnimation(.linear(duration: 1.2)) {
                                self.isAnimating.toggle()
                            }
                        }
                    }
                    .scaledToFit()
                    .scaleEffect(1.2)
            }
        }
        .frame(maxWidth: .infinity)
        .frame(height: 200)
        .shadow(color: .black.opacity(0.5), radius: 10, x: 3, y: 3)
        .padding()
        .modifier(PokemonShinyCardEffect(isAnimating: $isAnimating))
        .background {
            // MARK: - Pokemon Card Background
            PokemonCardBackgroundView(backgroundColor: pokemonColor)
        }
        .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
        .shadow(color: pokemonColor, radius: 2, x: 2, y: 2)
        .shadow(color: pokemonColor.opacity(0.8), radius: 8, x: 5, y: 5)
        .overlay(alignment: .bottom) {
            // MARK: - Pokemon Name
            Text(pokemon.name.uppercased())
                .frame(maxWidth: .infinity)
                .frame(height: 30)
                .font(.title3.weight(.heavy))
                .foregroundStyle(pokemonColor)
                .padding(5)
                .padding(.horizontal, 10)
                .background(.thickMaterial)
                .clipShape(Capsule())
                .padding(.bottom, 10)
                .padding(.horizontal, 10)
                .minimumScaleFactor(0.5)
                .lineLimit(1)
        }
        .overlay(alignment: .topLeading) {
            // MARK: - Pokemon ID
            Text("#\(String(pokemon.id))")
                .font(.system(.title3, design: .monospaced, weight: .heavy))
                .foregroundStyle(COLORS.PRIMARY_FONT)
                .padding(10)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
    }
}

// MARK: - PREVIEW
#Preview {
    PrimaryCollectionCellView(pokemon: .constant(MocPokemon.pikachu))
        .padding(20)
}
