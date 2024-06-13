//
//  PokemonSummaryBannerView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI
import Kingfisher

struct PokemonSummaryBannerView: View {
    // MARK: - PROPERTIES
    var pokemon: Binding<Pokemon>?
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - Pokémon Sprite Image
            if let stringUrl = pokemon?.sprites.officialArtwork.frontShiny.wrappedValue,
               let url = URL(string: stringUrl) {
                KFImage(url)
                    .resizable()
                    .placeholder {
                        ProgressView()
                    }
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .scaledToFit()
                    .safeAreaPadding(.top, Dimensions.isIphoneSE || Dimensions.isIpad ? 0 : 40)
            }
        }
        .frame(maxWidth: .infinity, alignment: .trailing)
        .modifier(PokemonShinyCardEffect(isAnimating: .constant(false)))
        .background {
            // MARK: - Background Card
            PokemonCardBackgroundView(backgroundColor: pokemon?.color.wrappedValue.actualColor ?? .black)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    GeometryReader { geo in
        PokemonSummaryBannerView(pokemon: MocPokemon.pikachu.binding(set: { _ in }))
    }
}
