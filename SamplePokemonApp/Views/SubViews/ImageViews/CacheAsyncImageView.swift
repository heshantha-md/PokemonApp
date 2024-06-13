//
//  CacheAsyncImageView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI
import Kingfisher

struct CacheAsyncImageView: View {
    // MARK: - PROPERTIES
    @State var url: URL
    var onSuccess: (() -> ())? = nil
    
    // MARK: - BODY
    var body: some View {
        KFImage(url)
            .resizable()
            .placeholder {
                ProgressView()
            }
            .loadDiskFileSynchronously()
            .cacheMemoryOnly()
            .fade(duration: 0.25)
            .onSuccess { result in
                onSuccess?()
            }
    }
}

// MARK: - PREVIEW
#Preview {
    ZStack {
        if let urlString = MocPokemon.pikachu.sprites.officialArtwork.frontShiny,
            let url = URL(string: urlString) {
            CacheAsyncImageView(url: url)
                .frame(width: 200, height: 200)
        }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .ignoresSafeArea()
}
