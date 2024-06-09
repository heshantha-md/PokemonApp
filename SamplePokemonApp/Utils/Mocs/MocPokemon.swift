//
//  MocPokemon.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 08/06/2024.
//

struct MocPokemon {
    struct POKEMON_NAME {
        static let PIKACHU = "pikachu"
        static let MEW = "mew"
        static let SQUIRTLE = "squirtle"
    }
    
    // MARK: - PIKACHU
    static let pikachu = Pokemon(id: 1,
                                 height: 4,
                                 sprites: Sprites(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/25.png",
                                                  backFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/female/25.png",
                                                  backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/25.png",
                                                  backShinyFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/female/25.png",
                                                  frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
                                                  frontFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/female/25.png",
                                                  frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/25.png",
                                                  frontShinyFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/female/25.png",
                                                  other: OtherSprites(dreamWorld: DreamWorldSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/25.svg",
                                                                                                    frontFemale: nil),
                                                                      home: HomeSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/25.png",
                                                                                        frontFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/female/25.png",
                                                                                        frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/25.png",
                                                                                        frontShinyFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/female/25.png"),
                                                                      officialArtwork: OfficialArtworkSprites(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/25.png",
                                                                                                              frontShinyFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/25.png"),
                                                                      showdown: ShowdownArtworkSprites(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/25.gif",
                                                                                                       backFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/female/25.gif",
                                                                                                       backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/25.gif",
                                                                                                       backShinyFemale: nil,
                                                                                                       frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/25.gif",
                                                                                                       frontFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/female/25.gif",
                                                                                                       frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/25.gif",
                                                                                                       frontShinyFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/female/25.gif"))))
    // MARK: - MEW
    static let mew = Pokemon(id: 2,
                             height: 4,
                             sprites: Sprites(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/151.png",
                                              backFemale: nil,
                                              backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/151.png",
                                              backShinyFemale: nil,
                                              frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/151.png",
                                              frontFemale: nil,
                                              frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/151.png",
                                              frontShinyFemale: nil,
                                              other: OtherSprites(dreamWorld: DreamWorldSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/151.svg",
                                                                                                frontFemale: nil),
                                                                  home: HomeSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/151.png",
                                                                                    frontFemale: nil,
                                                                                    frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/151.png",
                                                                                    frontShinyFemale: nil),
                                                                  officialArtwork: OfficialArtworkSprites(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/151.png",
                                                                                                          frontShinyFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/151.png"),
                                                                  showdown: ShowdownArtworkSprites(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/151.gif",
                                                                                                   backFemale: nil,
                                                                                                   backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/151.gif",
                                                                                                   backShinyFemale: nil,
                                                                                                   frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/151.gif",
                                                                                                   frontFemale: nil,
                                                                                                   frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/151.gif",
                                                                                                   frontShinyFemale: nil))))
    // MARK: - SQUIRTLE
    static let squirtle = Pokemon(id: 3,
                                  height: 5,
                                  sprites: Sprites(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/7.png",
                                                   backFemale: nil,
                                                   backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/back/shiny/7.png",
                                                   backShinyFemale: nil,
                                                   frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/7.png",
                                                   frontFemale: nil,
                                                   frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/shiny/7.png",
                                                   frontShinyFemale: nil,
                                                   other: OtherSprites(dreamWorld: DreamWorldSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/dream-world/7.svg",
                                                                                                     frontFemale: nil),
                                                                       home: HomeSprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/7.png",
                                                                                         frontFemale: nil,
                                                                                         frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/shiny/7.png",
                                                                                         frontShinyFemale: nil),
                                                                       officialArtwork: OfficialArtworkSprites(frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/7.png",
                                                                                                               frontShinyFemale: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/shiny/7.png"),
                                                                       showdown: ShowdownArtworkSprites(backDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/7.gif",
                                                                                                        backFemale: nil,
                                                                                                        backShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/back/shiny/7.gif",
                                                                                                        backShinyFemale: nil,
                                                                                                        frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/7.gif",
                                                                                                        frontFemale: nil,
                                                                                                        frontShiny: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/showdown/shiny/7.gif",
                                                                                                        frontShinyFemale: nil))))
}
