//
//  OtherSpritesDB.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

import SwiftData

@Model
final class OtherSpritesDB {
    // MARK: - PROPERTIES
    @Relationship(deleteRule: .cascade) var officialArtwork: OfficialArtworkSpritesDB?
    @Relationship(deleteRule: .cascade) var showdown: ShowdownArtworkSpritesDB?

    init(officialArtwork: OfficialArtworkSpritesDB?, showdown: ShowdownArtworkSpritesDB?) {
        self.officialArtwork = officialArtwork
        self.showdown = showdown
    }
}
