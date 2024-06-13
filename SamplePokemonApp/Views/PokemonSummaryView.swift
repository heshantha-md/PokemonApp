//
//  PokemonSummaryView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftUI
import Kingfisher

struct PokemonSummaryView: View {
    // MARK: - PROPERTIES
    @StateObject private var viewModel: Model
    
    // MARK: - INITIALIZERS
    init(model: Model) {
        _viewModel = StateObject(wrappedValue: model)
    }
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { mainGeo in
            VStack(spacing: 8) {
                // MARK: - Banner
                PokemonSummaryBannerView(pokemon: $viewModel.pokemon.wrappedValue,
                                     mainGeo: mainGeo)
                
                VStack(spacing: Dimensions.isIphoneSE ? 10 : 40) {
                    // MARK: - Pokémon Name
                    Text(viewModel.pokemon?.name.wrappedValue.uppercased() ?? "N/A")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .frame(minHeight: 40)
                        .multilineTextAlignment(.leading)
                        .font(Dimensions.isIpad ? .system(size: 44) : .system(.largeTitle))
                        .fontDesign(.monospaced)
                        .fontWeight(.heavy)
                        .foregroundStyle(COLORS.PRIMARY_FONT_BACKWARD)
                        .lineLimit(2)
                        .minimumScaleFactor(0.3)
                        .padding(.leading, (mainGeo.size.height / 3.7))
                        .padding(.vertical, 13)
                        .padding(.trailing, 15)
                    
                    ZStack {
                        // MARK: - Pokémon Scales
                        HStack {
                            PokemonScaleView(scaleType: .capture_rate, value: viewModel.pokemon?.base_happiness.wrappedValue ?? 0)
                            PokemonScaleView(scaleType: .happiness, value: viewModel.pokemon?.capture_rate.wrappedValue ?? 0)
                            PokemonScaleView(scaleType: .weight, value: viewModel.pokemon?.weight.wrappedValue ?? 0)
                            PokemonScaleView(scaleType: .height, value: viewModel.pokemon?.height.wrappedValue ?? 0)
                        }
                        .frame(maxWidth: Dimensions.isIpad ? 500 : .infinity)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .padding(.horizontal, 15)
                    
                    VStack(spacing: 15) {
                        // MARK: - Pokémon Stats
                        if let hp = viewModel.pokemon?.stat.hp.wrappedValue {
                            PokemonStatView(iconImage: IMAGES.STATS.HP,
                                            title: Constants.STATS.HP,
                                            baseStat: hp,
                                            maxStat: StatType.hp.max,
                                            percentage: viewModel.calculateStatPercentage(baseStat: hp, maxBaseStat: StatType.hp.max))
                        }
                        
                        if let attack = viewModel.pokemon?.stat.attack.wrappedValue {
                            PokemonStatView(iconImage: IMAGES.STATS.ATTACK,
                                            title: Constants.STATS.ATTACK,
                                            baseStat: attack,
                                            maxStat: StatType.attack.max,
                                            percentage: viewModel.calculateStatPercentage(baseStat: attack, maxBaseStat: StatType.attack.max))
                        }
                        
                        if let defense = viewModel.pokemon?.stat.defense.wrappedValue {
                            PokemonStatView(iconImage: IMAGES.STATS.DEFENSE,
                                            title: Constants.STATS.DEFENSE,
                                            baseStat: defense,
                                            maxStat: StatType.defense.max,
                                            percentage: viewModel.calculateStatPercentage(baseStat: defense, maxBaseStat: StatType.defense.max))
                        }
                        
                        if let specialAttack = viewModel.pokemon?.stat.specialAttack.wrappedValue {
                            PokemonStatView(iconImage: IMAGES.STATS.SPECIAL_ATTACK,
                                            title: Constants.STATS.SPECIAL_ATTACK,
                                            baseStat: specialAttack,
                                            maxStat: StatType.specialAttack.max,
                                            percentage: viewModel.calculateStatPercentage(baseStat: specialAttack, maxBaseStat: StatType.specialAttack.max))
                        }
                        
                        if let specialDefense = viewModel.pokemon?.stat.specialDefense.wrappedValue {
                            PokemonStatView(iconImage: IMAGES.STATS.SPECIAL_DEFENSE,
                                            title: Constants.STATS.SPECIAL_DEFENSE,
                                            baseStat: specialDefense,
                                            maxStat: StatType.specialDefense.max,
                                            percentage: viewModel.calculateStatPercentage(baseStat: specialDefense, maxBaseStat: StatType.specialDefense.max))
                        }
                        
                        if let speed = viewModel.pokemon?.stat.speed.wrappedValue {
                            PokemonStatView(iconImage: IMAGES.STATS.SPEED,
                                            title: Constants.STATS.SPEED,
                                            baseStat: speed,
                                            maxStat: StatType.speed.max,
                                            percentage: viewModel.calculateStatPercentage(baseStat: speed, maxBaseStat: StatType.speed.max))
                        }
                    }
                    .frame(maxWidth: Dimensions.isIpad ? 600 : .infinity)
                    .padding(.horizontal, 20)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(COLORS.PRIMARY_BG)
                .overlay(alignment: .topLeading) {
                    // MARK: - Pokémon Ball
                    PokeballView(pokemon: $viewModel.pokemon.wrappedValue,
                                 mainGeo: mainGeo)
                            .offset(x: 15, y: -(mainGeo.size.height / 8))
                }
            }
            .toolbar(.hidden)
            .background(.red)
        }
        .ignoresSafeArea(.all)
    }
}

// MARK: - PREVIEW
#Preview {
    PokemonSummaryView(model: PokemonSummaryView.Model(pokemon: .constant(MocPokemon.pikachu), service: PokemonService(manager: MocNetworkManager())))
}
