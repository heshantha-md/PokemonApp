//
//  PokemonDB.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftData

@Model
final class PokemonDB {
    // MARK: - PROPERTIES
    @Attribute(.unique) let id: Int
    private(set) var name: String
    private(set) var height: Int
    private(set) var color: String
    @Relationship(deleteRule: .cascade) private(set) var sprites: SpritesDB

    init(id: Int, name: String, height: Int, color: String, sprites: SpritesDB) {
        self.id = id
        self.name = name
        self.height = height
        self.color = color
        self.sprites = sprites
    }
    
    @MainActor
    func update(using pokemon: Pokemon) {
        self.name = pokemon.name
        self.height = pokemon.height
        self.color = pokemon.color.rawValue
        self.sprites = SpritesDB(backDefault: pokemon.sprites.backDefault,
                                 backFemale: pokemon.sprites.backFemale,
                                 backShiny: pokemon.sprites.backShiny,
                                 backShinyFemale: pokemon.sprites.backShinyFemale,
                                 frontDefault: pokemon.sprites.frontDefault,
                                 frontFemale: pokemon.sprites.frontFemale,
                                 frontShiny: pokemon.sprites.frontShiny,
                                 frontShinyFemale: pokemon.sprites.frontShinyFemale,
                                 other: OtherSpritesDB(officialArtwork: OfficialArtworkSpritesDB(frontShiny: pokemon.sprites.other?.officialArtwork?.frontShiny,
                                                                                                 frontShinyFemale: pokemon.sprites.other?.officialArtwork?.frontShinyFemale),
                                                       showdown: ShowdownArtworkSpritesDB(backDefault: pokemon.sprites.other?.showdown?.backDefault,
                                                                                          backFemale: pokemon.sprites.other?.showdown?.backFemale,
                                                                                          backShiny: pokemon.sprites.other?.showdown?.backShiny,
                                                                                          backShinyFemale: pokemon.sprites.other?.showdown?.backShinyFemale,
                                                                                          frontDefault: pokemon.sprites.other?.showdown?.frontDefault,
                                                                                          frontFemale: pokemon.sprites.other?.showdown?.frontFemale,
                                                                                          frontShiny: pokemon.sprites.other?.showdown?.frontShiny,
                                                                                          frontShinyFemale: pokemon.sprites.other?.showdown?.frontShinyFemale)))
    }
}

extension PokemonDB: Identifiable {
    static func == (lhs: PokemonDB, rhs: PokemonDB) -> Bool {
        return lhs.id == rhs.id
    }
}

extension PokemonDB: Hashable {
    func hash(into hasher: inout Hasher) {
      hasher.combine(id)
    }
}

extension PokemonDB: Comparable {
    static func < (lhs: PokemonDB, rhs: PokemonDB) -> Bool {
        return lhs.id < rhs.id
    }
}

extension PokemonDB {
    var asPokemon: Pokemon {
        Pokemon(id: self.id,
                name: self.name,
                color: PokeColor.pokemonColor(by: self.color),
                height: self.height,
                sprites: Sprites(backDefault: self.sprites.backDefault,
                                 backFemale: self.sprites.backFemale,
                                 backShiny: self.sprites.backShiny,
                                 backShinyFemale: self.sprites.backShinyFemale,
                                 frontDefault: self.sprites.frontDefault,
                                 frontFemale: self.sprites.frontFemale,
                                 frontShiny: self.sprites.frontShiny,
                                 frontShinyFemale: self.sprites.frontShinyFemale,
                                 other: OtherSprites(officialArtwork:
                                                            OfficialArtworkSprites(frontShiny: self.sprites.other?.officialArtwork?.frontShiny,
                                                                                   frontShinyFemale: self.sprites.other?.officialArtwork?.frontShinyFemale),
                                                     showdown:
                                                            ShowdownArtworkSprites(backDefault: self.sprites.other?.showdown?.backDefault,
                                                                                   backFemale: self.sprites.other?.showdown?.backFemale,
                                                                                   backShiny: self.sprites.other?.showdown?.backShiny,
                                                                                   backShinyFemale: self.sprites.other?.showdown?.backShinyFemale,
                                                                                   frontDefault: self.sprites.other?.showdown?.frontDefault,
                                                                                   frontFemale: self.sprites.other?.showdown?.frontFemale,
                                                                                   frontShiny: self.sprites.other?.showdown?.frontShiny,
                                                                                   frontShinyFemale: self.sprites.other?.showdown?.frontShinyFemale))))
    }
}
