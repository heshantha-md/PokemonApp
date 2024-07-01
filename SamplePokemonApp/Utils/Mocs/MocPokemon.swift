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
    static let pikachu = Pokemon(id: 2275836299,
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
    
    static let pikachuDecodable = PokemonCodable(id: 2275836299,
                                                   name: MocPokemon.POKEMON_NAME.PIKACHU,
                                                   height: 4,
                                                   species: PokemonSpeciesCodable(name: "pikachu",
                                                                                    url: "https://pokeapi.co/api/v2/pokemon-species/25/"),
                                                   sprites: SpritesCodable(other: OtherSpritesCodable(officialArtwork: OfficialArtworkSpritesCodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/25.png"), showdown: ShowdownArtworkSpritesCodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/25.gif", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/25.gif"))),
                                                   abilities: [AbilitiesCodable(ability: AbilityCodable(name: "static")), AbilitiesCodable(ability: AbilityCodable(name: "lightning-rod"))],
                                                   stats: [StatsCodable(baseStat: 35, stat: StatCodable(name: "hp")), StatsCodable(baseStat: 55, stat: StatCodable(name: "attack")), StatsCodable(baseStat: 40, stat: StatCodable(name: "defense")), StatsCodable(baseStat: 50, stat: StatCodable(name: "special-attack")), StatsCodable(baseStat: 50, stat: StatCodable(name: "special-defense")), StatsCodable(baseStat: 90, stat: StatCodable(name: "speed"))],
                                                   weight: 60)
    
    static let pikachuSpeciesDetailDecodable = PokemonSpeciesDetailCodable(base_happiness: 200, capture_rate: 50, color: PokemonColorCodable(name: "yellow"))
    
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
    
    static let mewDecodable = PokemonCodable(id: 1516739588,
                                               name: MocPokemon.POKEMON_NAME.MEW,
                                               height: 4,
                                               species: PokemonSpeciesCodable(name: "mew", url: "https://pokeapi.co/api/v2/pokemon-species/151/"),
                                               sprites: SpritesCodable(other: OtherSpritesCodable(officialArtwork: OfficialArtworkSpritesCodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/151.png", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/151.png"), showdown: ShowdownArtworkSpritesCodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/151.gif", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/151.gif"))),
                                               abilities: [AbilitiesCodable(ability: AbilityCodable(name: "synchronize"))],
                                               stats: [StatsCodable(baseStat: 100, stat: StatCodable(name: "hp")), StatsCodable(baseStat: 100, stat: StatCodable(name: "attack")), StatsCodable(baseStat: 100, stat: StatCodable(name: "defense")), StatsCodable(baseStat: 100, stat: StatCodable(name: "special-attack")), StatsCodable(baseStat: 100, stat: StatCodable(name: "special-defense")), StatsCodable(baseStat: 100, stat: StatCodable(name: "speed"))],
                                               weight: 40)
    
    static let mewSpeciesDetailDecodable = PokemonSpeciesDetailCodable(base_happiness: 100, capture_rate: 0, color: PokemonColorCodable(name: "pink"))
    
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
    
    static let squirtleDecodable = PokemonCodable(id: 7563925278,
                                                    name: MocPokemon.POKEMON_NAME.SQUIRTLE,
                                                    height: 5,
                                                    species: PokemonSpeciesCodable(name: "squirtle", url: "https://pokeapi.co/api/v2/pokemon-species/7/"),
                                                    sprites: SpritesCodable(other: OtherSpritesCodable(officialArtwork: OfficialArtworkSpritesCodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/7.png"), showdown: ShowdownArtworkSpritesCodable(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/7.gif", backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/7.gif"))),
                                                    abilities: [AbilitiesCodable(ability: AbilityCodable(name: "torrent")), AbilitiesCodable(ability: AbilityCodable(name: "rain-dish"))],
                                                    stats: [StatsCodable(baseStat: 35, stat: StatCodable(name: "hp")), StatsCodable(baseStat: 55, stat: StatCodable(name: "attack")), StatsCodable(baseStat: 40, stat: StatCodable(name: "defense")), StatsCodable(baseStat: 50, stat: StatCodable(name: "special-attack")), StatsCodable(baseStat: 50, stat: StatCodable(name: "special-defense")), StatsCodable(baseStat: 90, stat: StatCodable(name: "speed"))],
                                                    weight: 90)
    
    static let squirtleSpeciesDetailDecodable = PokemonSpeciesDetailCodable(base_happiness: 30, capture_rate: 20, color: PokemonColorCodable(name: "blue"))
}
