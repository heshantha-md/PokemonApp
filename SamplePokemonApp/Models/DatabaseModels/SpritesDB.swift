//
//  SpritesDB.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftData

@Model
final class SpritesDB {
    // MARK: - PROPERTIES
    let backDefault: String?
    let backFemale: String?
    let backShiny: String?
    let backShinyFemale: String?
    let frontDefault: String?
    let frontFemale: String?
    let frontShiny: String?
    let frontShinyFemale: String?
    @Relationship(deleteRule: .cascade) var other: OtherSpritesDB?

    init(backDefault: String?, backFemale: String?, backShiny: String?, backShinyFemale: String?, frontDefault: String?, frontFemale: String?, frontShiny: String?, frontShinyFemale: String?, other: OtherSpritesDB?) {
        self.backDefault = backDefault
        self.backFemale = backFemale
        self.backShiny = backShiny
        self.backShinyFemale = backShinyFemale
        self.frontDefault = frontDefault
        self.frontFemale = frontFemale
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
        self.other = other
    }
}
