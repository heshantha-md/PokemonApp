//
//  HomeNavigationBar.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct HomeNavigationBar: View {
    // MARK: - PROPERTIES
    @Binding var scrollTransection: CGFloat
    @Binding var searchText: String
    var searchCancelAction: (() -> ())? = nil
    var logoScale: CGFloat {
        withAnimation(.easeIn(duration: 0.2)) {
            let scaleValue = scrollTransection / 150
            return scaleValue > 1 ? 1 : scaleValue > 0.5 ? scaleValue : 0.5
        }
    }
    
    // MARK: - BODY
    var body: some View {
        ZStack {
            // MARK: - App Logo
            IMAGES.LOGO
                .resizable()
                .frame(maxWidth: 400)
                .frame(height: 150)
                .padding(.horizontal, 15)
                .scaleEffect(logoScale)
                .animation(.easeInOut(duration: 0.5), value: logoScale)
                .offset(y: -50)
                .padding(.bottom, -50)
                .shadow(color: .black.opacity(logoScale < 1 ? 1 : 0), radius: 5, x: 3, y: 3)
        }
        .frame(minWidth: 300, maxWidth: .infinity)
        .background {
            Rectangle()
                .fill(Color.accentColor.opacity(0.5))
                .ignoresSafeArea(.all)
                .opacity(logoScale < 1 ? 1 : 0)
                .animation(.easeIn(duration: 0.1), value: logoScale)
        }
        .overlay(alignment: .bottom) {
            // MARK: - Search Bar
            HStack {
                IMAGES.MAGNIFYING_GLASS_ICON
                    .font(.largeTitle)
                
                TextField(Constants.POKEMONS_NAME, text: $searchText)
                    .frame(height: 35)
                    .font(.system(.title3,
                                  design: .monospaced,
                                  weight: .heavy))
                    .padding(.horizontal, 10)
                    .background(.thinMaterial)
                    .clipShape(RoundedRectangle(cornerRadius: 10, style: .continuous))
                
                Button(Constants.CANCEL.uppercased()) {
                    searchCancelAction?()
                }
                .frame(width: 60)
                .buttonStyle(SimpleButton())
            }
            .frame(maxWidth: 500)
            .foregroundStyle(COLORS.SECONDARY_FONT_COLOR)
            .padding(.horizontal, 15)
            .padding(.bottom, 5)
            .opacity(logoScale < 0.6 ? 1 : 0)
            .animation(.easeIn(duration: 0.2), value: logoScale)
        }
    }
}

// MARK: - PREVIEW
#Preview {
    HomeNavigationBar(scrollTransection: .constant(267),
                      searchText: .constant(""))
}
