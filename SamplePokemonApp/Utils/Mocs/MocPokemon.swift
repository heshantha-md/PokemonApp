//
//  MocPokemon.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 08/06/2024.
//

import SwiftUI

struct MocPokemon {
    struct POKEMON_NAME {
        static let PIKACHU = "pikachu"
        static let MEW = "mew"
        static let SQUIRTLE = "squirtle"
    }
    
    // MARK: - PIKACHU
    static let pikachu = Pokemon(id: 25,
                                 name: MocPokemon.POKEMON_NAME.PIKACHU,
                                 height: 4,
                                 weight: 60, 
                                 species: Species(name: "pikachu", url: "https://pokeapi.co/api/v2/pokemon-species/25/"),
                                 sprites: Sprites(officialArtwork: OfficialArtworkSprites(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                                                                                          
                                                                                          backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/25.png"),
                                                  showdown: ShowdownArtworkSprites(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/25.gif",
                                                                                   backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/25.gif")),
                                 abilities: [Ability(name: "static"), Ability(name: "lightning-rod")],
                                 stat: Stat(hp: 35, attack: 55, defense: 40, specialAttack: 50, specialDefense: 50, speed: 90),
                                 base_happiness: 200,
                                 capture_rate: 50,
                                 color: PokeColor.yellow)
    
    static let pikachuDecodable = PokemonDecodable(id: 1,
                                                   name: MocPokemon.POKEMON_NAME.PIKACHU,
                                                   height: 4,
                                                   species: PokemonSpeciesDecodable(name: "pikachu",
                                                                                    url: "https://pokeapi.co/api/v2/pokemon-species/25/"),
                                                   sprites: SpritesDecodable(other: OtherSpritesDecodable(officialArtwork: OfficialArtworkSpritesDecodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/25.png"), showdown: ShowdownArtworkSpritesDecodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/25.gif", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/25.gif"))),
                                                   abilities: [AbilitiesDecodable(ability: AbilityDecodable(name: "static")), AbilitiesDecodable(ability: AbilityDecodable(name: "lightning-rod"))],
                                                   stats: [StatsDecodable(baseStat: 35, stat: StatDecodable(name: "hp")), StatsDecodable(baseStat: 55, stat: StatDecodable(name: "attack")), StatsDecodable(baseStat: 40, stat: StatDecodable(name: "defense")), StatsDecodable(baseStat: 50, stat: StatDecodable(name: "special-attack")), StatsDecodable(baseStat: 50, stat: StatDecodable(name: "special-defense")), StatsDecodable(baseStat: 90, stat: StatDecodable(name: "speed"))],
                                                   weight: 60)
    
    static let pikachuSpeciesDetailDecodable = PokemonSpeciesDetailDecodable(base_happiness: 200, capture_rate: 50, color: PokemonColorDecodable(name: "yellow"))
    
    // MARK: - MEW
    static let mew = Pokemon(id: 1516739588,
                             name: MocPokemon.POKEMON_NAME.MEW,
                             height: 4,
                             weight: 40,
                             species: Species(name: "mew", url: "https://pokeapi.co/api/v2/pokemon-species/151/"),
                             sprites: Sprites(officialArtwork: OfficialArtworkSprites(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/151.png",
                                                                                      backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/151.png"),
                                              showdown: ShowdownArtworkSprites(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/151.gif",
                                                                               backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/151.gif")),
                             abilities: [Ability(name: "synchronize")],
                             stat: Stat(hp: 100, attack: 100, defense: 100, specialAttack: 100, specialDefense: 100, speed: 100),
                             base_happiness: 100,
                             capture_rate: 0,
                             color: PokeColor.pink)
    
    static let mewDecodable = PokemonDecodable(id: 2275836299,
                                               name: MocPokemon.POKEMON_NAME.MEW,
                                               height: 4,
                                               species: PokemonSpeciesDecodable(name: "mew", url: "https://pokeapi.co/api/v2/pokemon-species/151/"),
                                               sprites: SpritesDecodable(other: OtherSpritesDecodable(officialArtwork: OfficialArtworkSpritesDecodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/151.png", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/151.png"), showdown: ShowdownArtworkSpritesDecodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/151.gif", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/151.gif"))),
                                               abilities: [AbilitiesDecodable(ability: AbilityDecodable(name: "synchronize"))],
                                               stats: [StatsDecodable(baseStat: 100, stat: StatDecodable(name: "hp")), StatsDecodable(baseStat: 100, stat: StatDecodable(name: "attack")), StatsDecodable(baseStat: 100, stat: StatDecodable(name: "defense")), StatsDecodable(baseStat: 100, stat: StatDecodable(name: "special-attack")), StatsDecodable(baseStat: 100, stat: StatDecodable(name: "special-defense")), StatsDecodable(baseStat: 100, stat: StatDecodable(name: "speed"))],
                                               weight: 40)
    
    static let mewSpeciesDetailDecodable = PokemonSpeciesDetailDecodable(base_happiness: 100, capture_rate: 0, color: PokemonColorDecodable(name: "pink"))
    
    // MARK: - SQUIRTLE
    static let squirtle = Pokemon(id: 7563925278,
                                  name: MocPokemon.POKEMON_NAME.SQUIRTLE,
                                  height: 5,
                                  weight: 90,
                                  species: Species(name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon-species/7/"),
                                  sprites: Sprites(officialArtwork: OfficialArtworkSprites(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png",
                                                                                           backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/7.png"),
                                                   showdown: ShowdownArtworkSprites(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/7.gif",
                                                                                    backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/7.gif")),
                                  abilities: [Ability(name: "torrent"), Ability(name: "rain-dish")],
                                  stat: Stat(hp: 44, attack: 48, defense: 65, specialAttack: 50, specialDefense: 64, speed: 43),
                                  base_happiness: 30,
                                  capture_rate: 20,
                                  color: PokeColor.blue)
    
    static let squirtleDecodable = PokemonDecodable(id: 3,
                                                    name: MocPokemon.POKEMON_NAME.SQUIRTLE,
                                                    height: 5,
                                                    species: PokemonSpeciesDecodable(name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon-species/7/"),
                                                    sprites: SpritesDecodable(other: OtherSpritesDecodable(officialArtwork: OfficialArtworkSpritesDecodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/7.png"), showdown: ShowdownArtworkSpritesDecodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/7.gif", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/7.gif"))),
                                                    abilities: [AbilitiesDecodable(ability: AbilityDecodable(name: "torrent")), AbilitiesDecodable(ability: AbilityDecodable(name: "rain-dish"))],
                                                    stats: [StatsDecodable(baseStat: 35, stat: StatDecodable(name: "hp")), StatsDecodable(baseStat: 55, stat: StatDecodable(name: "attack")), StatsDecodable(baseStat: 40, stat: StatDecodable(name: "defense")), StatsDecodable(baseStat: 50, stat: StatDecodable(name: "special-attack")), StatsDecodable(baseStat: 50, stat: StatDecodable(name: "special-defense")), StatsDecodable(baseStat: 90, stat: StatDecodable(name: "speed"))],
                                                    weight: 90)
    
    static let squirtleSpeciesDetailDecodable = PokemonSpeciesDetailDecodable(base_happiness: 30, capture_rate: 20, color: PokemonColorDecodable(name: "blue"))
}
