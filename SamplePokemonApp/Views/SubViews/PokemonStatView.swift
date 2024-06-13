//
//  PokemonStatView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

import SwiftUI

struct PokemonStatView: View {
    // MARK: - PROPERTIES
    var iconImage: Image
    @State var title: String
    @State var baseStat: Int
    @State var maxStat: Int
    @State var percentage: Float
    
    var body: some View {
        HStack {
            // MARK: - Stat Icon
            iconImage
                .frame(width: 40, height: 40)
                .foregroundStyle(COLORS.PRIMARY_FONT_BACKWARD)
                .scaledToFit()
            
            VStack(alignment: .leading, spacing: 5) {
                HStack {
                    // MARK: - Stat Label
                    Text(title)
                    Spacer()
                    // MARK: - Stat Value
                    Text("\(baseStat)/\(maxStat)")
                }
                .padding(.trailing, 10)
                .foregroundStyle(COLORS.PRIMARY_FONT_BACKWARD)
                PrimaryProgressBar(percentage: percentage)
            }
            .font(.system(.caption, design: .default, weight: .heavy))
        }
    }
}

// MARK: - PREVIEW
#Preview {
    ZStack {
        PokemonStatView(iconImage: IMAGES.STATS.HP,
                        title: Constants.STATS.HP,
                        baseStat: 40,
                        maxStat: 255,
                        percentage: 80)
        .padding(20)
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
}
