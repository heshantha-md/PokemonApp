//
//  PokemonSummaryView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftUI

struct PokemonSummaryView: View {
    // MARK: - PROPERTIES
    @Environment(\.dismiss) var dismiss
    @StateObject private var viewModel: Model
    @State private var isInLandscape: Bool = false
    
    // MARK: - INITIALIZERS
    init(model: Model) {
        _viewModel = StateObject(wrappedValue: model)
    }
    
    // MARK: - BODY
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 15) {
                if isInLandscape {
                    // MARK: - Pokémon Scales
                    PokemonScalesView(pokemon: $viewModel.pokemon.wrappedValue)
                            .frame(maxWidth: 600)
                            .padding(.vertical, 15)
                            .accessibilityLabel("Pokémon Scales")
                            .accessibilityHint("Displays the scales of the Pokémon")
                }
                
                // MARK: - Adaptable stack to support landscape mode
                LandscapeAdaptableStack {
                    Group {
                        VStack {
                            // MARK: - Banner
                            PokemonSummaryBannerView(pokemon: $viewModel.pokemon.wrappedValue)
                            .opacity(isInLandscape ? 0 : 1)
                            .overlay(alignment: isInLandscape ? .center : .bottomLeading) {
                                // MARK: - Pokémon Ball
                                PokeballView(pokemon: $viewModel.pokemon.wrappedValue)
                                    .frame(maxWidth: .infinity, maxHeight: isInLandscape ? .infinity : 180, alignment: .center)
                                    .offset(x: isInLandscape ? 0 : Dimensions.isIpad ? -50 : -10, y: isInLandscape ? 0 : Dimensions.isIpad ? 0 : 60)
                                    .accessibilityLabel("Pokeball")
                                    .accessibilityHint("Displays the animating Pokémon sprite both front and backside")
                            }
                            
                            ZStack {
                                // MARK: - Pokémon Name
                                Text(viewModel.pokemon?.name.wrappedValue.uppercased() ?? "N/A")
                                    .frame(maxWidth: isInLandscape ? .infinity : geo.size.width / 2.2, alignment: isInLandscape ? .center : .leading)
                                    .frame(height: 50)
                                    .font(Dimensions.isIpad ? .system(size: 44) : .system(.largeTitle))
                                    .fontDesign(.monospaced)
                                    .fontWeight(.heavy)
                                    .foregroundStyle(COLORS.PRIMARY_FONT_BACKWARD)
                                    .lineLimit(2)
                                    .multilineTextAlignment(.center)
                                    .minimumScaleFactor(0.3)
                                    .padding(.trailing, isInLandscape ? 0 : 10)
                                    .padding(.bottom, isInLandscape ? 40 : 0)
                                    .accessibilityLabel("Pokémon Name")
                                    .accessibilityValue(viewModel.pokemon?.name.wrappedValue ?? "Not available")
                            }
                            .frame(maxWidth: .infinity, alignment: .trailing)
                        }
                        .frame(maxWidth: .infinity, maxHeight: isInLandscape ? .infinity : (geo.size.height / 2.5))
                        .padding(isInLandscape ? .leading : .horizontal, isInLandscape ? 60 : 0)
                        
                        if !isInLandscape {
                            // MARK: - Pokémon Scales
                            PokemonScalesView(pokemon: $viewModel.pokemon.wrappedValue)
                                .padding(.top, 5)
                                .accessibilityLabel("Pokémon Scales")
                                .accessibilityHint("Displays the scales of the Pokémon")
                        }
                        
                        VStack {
                            // MARK: - Pokémon Stats
                            if let hp = viewModel.pokemon?.stat.hp.wrappedValue {
                                PokemonStatView(iconImage: IMAGES.STATS.HP,
                                                title: Constants.STATS.HP,
                                                baseStat: hp,
                                                maxStat: StatType.hp.max,
                                                percentage: viewModel.calculateStatPercentage(baseStat: hp, maxBaseStat: StatType.hp.max))
                                                    .accessibilityElement(children: .combine)
                                                    .accessibilityLabel("HP")
                                                    .accessibilityValue("\(hp) out of \(StatType.hp.max)")
                                                    .accessibilityHint("Displays the health points of the Pokémon")
                            }
                            
                            if let attack = viewModel.pokemon?.stat.attack.wrappedValue {
                                PokemonStatView(iconImage: IMAGES.STATS.ATTACK,
                                                title: Constants.STATS.ATTACK,
                                                baseStat: attack,
                                                maxStat: StatType.attack.max,
                                                percentage: viewModel.calculateStatPercentage(baseStat: attack, maxBaseStat: StatType.attack.max))
                                                    .accessibilityElement(children: .combine)
                                                    .accessibilityLabel("Attack")
                                                    .accessibilityValue("\(attack) out of \(StatType.attack.max)")
                                                    .accessibilityHint("Displays the attack points of the Pokémon")
                            }
                            
                            if let defense = viewModel.pokemon?.stat.defense.wrappedValue {
                                PokemonStatView(iconImage: IMAGES.STATS.DEFENSE,
                                                title: Constants.STATS.DEFENSE,
                                                baseStat: defense,
                                                maxStat: StatType.defense.max,
                                                percentage: viewModel.calculateStatPercentage(baseStat: defense, maxBaseStat: StatType.defense.max))
                                                    .accessibilityElement(children: .combine)
                                                    .accessibilityLabel("Defense")
                                                    .accessibilityValue("\(defense) out of \(StatType.defense.max)")
                                                    .accessibilityHint("Displays the defense points of the Pokémon")
                            }
                            
                            if let specialAttack = viewModel.pokemon?.stat.specialAttack.wrappedValue {
                                PokemonStatView(iconImage: IMAGES.STATS.SPECIAL_ATTACK,
                                                title: Constants.STATS.SPECIAL_ATTACK,
                                                baseStat: specialAttack,
                                                maxStat: StatType.specialAttack.max,
                                                percentage: viewModel.calculateStatPercentage(baseStat: specialAttack, maxBaseStat: StatType.specialAttack.max))
                                                    .accessibilityElement(children: .combine)
                                                    .accessibilityLabel("Special Attack")
                                                    .accessibilityValue("\(specialAttack) out of \(StatType.specialAttack.max)")
                                                    .accessibilityHint("Displays the special attack points of the Pokémon")
                            }
                            
                            if let specialDefense = viewModel.pokemon?.stat.specialDefense.wrappedValue {
                                PokemonStatView(iconImage: IMAGES.STATS.SPECIAL_DEFENSE,
                                                title: Constants.STATS.SPECIAL_DEFENSE,
                                                baseStat: specialDefense,
                                                maxStat: StatType.specialDefense.max,
                                                percentage: viewModel.calculateStatPercentage(baseStat: specialDefense, maxBaseStat: StatType.specialDefense.max))
                                                    .accessibilityElement(children: .combine)
                                                    .accessibilityLabel("Special Defense")
                                                    .accessibilityValue("\(specialDefense) out of \(StatType.specialDefense.max)")
                                                    .accessibilityHint("Displays the special defense points of the Pokémon")
                            }
                            
                            if let speed = viewModel.pokemon?.stat.speed.wrappedValue {
                                PokemonStatView(iconImage: IMAGES.STATS.SPEED,
                                                title: Constants.STATS.SPEED,
                                                baseStat: speed,
                                                maxStat: StatType.speed.max,
                                                percentage: viewModel.calculateStatPercentage(baseStat: speed, maxBaseStat: StatType.speed.max))
                                                    .accessibilityElement(children: .combine)
                                                    .accessibilityLabel("Speed")
                                                    .accessibilityValue("\(speed) out of \(StatType.speed.max)")
                                                    .accessibilityHint("Displays the speed points of the Pokémon")
                            }
                            
                            
                            Spacer()
                        }
                        .frame(maxWidth: Dimensions.isIpad ? 600 : .infinity, maxHeight: .infinity, alignment: .top)
                        .padding(isInLandscape ? .trailing : .horizontal, isInLandscape ? 60 : 20)
                    }
                }
            }
            .padding(.vertical, isInLandscape ? 10 : 0)
            .overlay(alignment: .topLeading) {
                // MARK: - Back Button
                Button { dismiss() } label: {
                    Image(systemName: "chevron.backward.square.fill")
                        .font(.largeTitle)
                }
                .frame(width: 70, height: 50)
                .buttonStyle(SimpleButton())
                .foregroundStyle(.black)
                .offset(y: Dimensions.isIphoneSE ? 40 : 70)
                .accessibilityLabel("Back")
                .accessibilityHint("Go back to the Home screen")
            }
            .background(COLORS.PRIMARY_BG)
            .onChange(of: geo.size.height) {
                isInLandscape = Dimensions.isInLandscape(width: geo.size.width, height: geo.size.height)
            }
            .onAppear {
                isInLandscape = Dimensions.isInLandscape(width: geo.size.width, height: geo.size.height)
            }
        }
        .ignoresSafeArea(.all)
        .toolbar(.hidden)
        .background(.red)
    }
}

// MARK: - PREVIEW
#Preview {
    PokemonSummaryView(model: PokemonSummaryView.Model(pokemon: .constant(MocPokemon.pikachu), service: PokemonService(manager: MocNetworkManager())))
}
