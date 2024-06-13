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
    @Environment(\.dismiss) var dismiss
    var pokemon: Binding<Pokemon>?
    @State var mainGeo: GeometryProxy
    
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
        .frame(height: (mainGeo.size.height / 3))
        .modifier(PokemonShinyCardEffect(isAnimating: .constant(false)))
        .background {
            // MARK: - Background Card
            PokemonCardBackgroundView(backgroundColor: pokemon?.color.wrappedValue.actualColor ?? .black)
        }
        .overlay(alignment: .topLeading) {
            // MARK: - Back Button
            Button { dismiss() } label: {
                Image(systemName: "chevron.backward.square.fill")
                    .font(.largeTitle)
            }
            .frame(width: 70)
            .buttonStyle(SimpleButton())
            .foregroundStyle(.black)
            .offset(y: Dimensions.isIphoneSE ? 30 : 70)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    GeometryReader { geo in
        PokemonSummaryBannerView(pokemon: MocPokemon.pikachu.binding(set: { _ in }),
                             mainGeo: geo)
    }
}
