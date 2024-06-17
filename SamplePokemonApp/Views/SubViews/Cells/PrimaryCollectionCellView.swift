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
    var favoriteAction: (_ isFavorite: Bool) -> ()?
    
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
                            .accessibilityLabel("Loading image")
                    }
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .onSuccess { result in
                        withAnimation(.linear(duration: 1.2)) {
                            self.isAnimating.toggle()
                        }
                    }
                    .scaledToFit()
                    .scaleEffect(1.2)
                    .accessibilityLabel("\(pokemon.name) Image")
                    .accessibilityHint("Displays the sprite of \(pokemon.name)")
            }
        }
        .frame(minWidth: 80, maxWidth: .infinity,
               minHeight: 80, maxHeight: 200)
        .shadow(color: .black.opacity(0.5), radius: 10, x: 3, y: 3)
        .padding()
        .modifier(PokemonShinyCardEffect(isAnimating: $isAnimating))
        .background {
            // MARK: - Pokemon Card Background
            PokemonCardBackgroundView(backgroundColor: pokemonColor)
                .accessibilityHidden(true)
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
                .accessibilityLabel("Pokémon Name")
                .accessibilityValue(pokemon.name)
        }
        .overlay(alignment: .top) {
            HStack {
                Group {
                    // MARK: - Pokemon ID
                    Text("#\(String(pokemon.id))")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .lineLimit(1)
                        .accessibilityLabel("Pokémon ID")
                        .accessibilityValue("#\(pokemon.id)")
                    
                    Button(action: { favoriteAction(pokemon.isFavorite) }) {
                        pokemon.isFavorite ? IMAGES.IC_HEART_FILL : IMAGES.IC_HEART
                    }
                }
                .font(.system(.title3, design: .monospaced, weight: .heavy))
                .foregroundStyle(COLORS.PRIMARY_FONT)
            }
            .padding(10)
        }
        .padding(.horizontal, 15)
        .padding(.vertical, 10)
        .accessibilityElement(children: .combine)
        .accessibilityLabel("\(pokemon.name), ID: \(pokemon.id)")
        .accessibilityHint("A card displaying \(pokemon.name) with its ID and image")
    }
}

// MARK: - PREVIEW
#Preview {
    PrimaryCollectionCellView(pokemon: .constant(MocPokemon.pikachu), favoriteAction: { _ in })
        .padding(20)
}
