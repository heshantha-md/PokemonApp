//
//  OtherSpritesDecodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

struct OtherSpritesDecodable: Decodable {
    // MARK: - PROPERTIES
    var officialArtwork: OfficialArtworkSpritesDecodable
    var showdown: ShowdownArtworkSpritesDecodable
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
        case showdown
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.officialArtwork = try container.decode(OfficialArtworkSpritesDecodable.self, forKey: .officialArtwork)
        self.showdown = try container.decode(ShowdownArtworkSpritesDecodable.self, forKey: .showdown)
    }
    
    init(officialArtwork: OfficialArtworkSpritesDecodable, showdown: ShowdownArtworkSpritesDecodable) {
        self.officialArtwork = officialArtwork
        self.showdown = showdown
    }
}
