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
        ZStack {
            // MARK: - Sprite Image
            if let stringUrl = pokemon.sprites.other?.officialArtwork?.frontShiny,
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
        .frame(minWidth: 0, maxWidth: .infinity)
        .frame(height: 200)
        .shadow(color: .black.opacity(0.5), radius: 10, x: 3, y: 3)
        .padding()
        .overlay {
            // MARK: - Card Shiny Effect
            LinearGradient(colors: COLORS.SHINY_WHITE, startPoint: .bottomTrailing, endPoint: .topLeading)
                .offset(x: self.isAnimating ? 100 : -100, y: -80)
                .rotationEffect(Angle(degrees: 60), anchor: .topLeading)
                .scaleEffect(3)
        }
        .background {
            // MARK: - Pokemon Card Background
            LinearGradient(colors: COLORS.SHINY_WHITE, startPoint: .topLeading, endPoint: .bottomTrailing)
                .border(.gray.opacity(0.1), width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
        }
        .background(pokemon.color)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .shadow(color: pokemon.color, radius: 2, x: 2, y: 2)
        .shadow(color: pokemon.color.opacity(0.8), radius: 8, x: 5, y: 5)
        .overlay(alignment: .bottom) {
            // MARK: - Pokemon Name
            Text(pokemon.name.uppercased())
                .frame(minWidth: 0, maxWidth: .infinity)
                .frame(height: 30)
                .font(.title3.weight(.heavy))
                .foregroundStyle(pokemon.color)
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
            Text("#\(pokemon.id)")
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
