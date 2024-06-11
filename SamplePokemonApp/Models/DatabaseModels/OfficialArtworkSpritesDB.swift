//
//  OfficialArtworkSpritesDB.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftData

@Model
final class OfficialArtworkSpritesDB {
    // MARK: - PROPERTIES
    let frontShiny: String?
    let frontShinyFemale: String?

    init(frontShiny: String?, frontShinyFemale: String?) {
        self.frontShiny = frontShiny
        self.frontShinyFemale = frontShinyFemale
    }
}
