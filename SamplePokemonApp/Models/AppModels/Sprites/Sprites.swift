//
//  Sprites.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 12/06/2024.
//

struct Sprites {
    // MARK: - PROPERTIES
    var officialArtwork: OfficialArtworkSprites
    var showdown: ShowdownArtworkSprites
    
    // MARK: - INITIALIZERS
    init(officialArtwork: OfficialArtworkSprites, showdown: ShowdownArtworkSprites) {
        self.officialArtwork = officialArtwork
        self.showdown = showdown
    }
}
