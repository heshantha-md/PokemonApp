//
//  OtherSpritesCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

struct OtherSpritesCodable: Codable {
    // MARK: - PROPERTIES
    var officialArtwork: OfficialArtworkSpritesCodable
    var showdown: ShowdownArtworkSpritesCodable
    
    enum CodingKeys: String, CodingKey {
        case officialArtwork = "official-artwork"
        case showdown
    }
    
    // MARK: - ENCODING
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(officialArtwork, forKey: .officialArtwork)
        try container.encode(showdown, forKey: .showdown)
    }
    
    // MARK: - DECODING
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.officialArtwork = try container.decode(OfficialArtworkSpritesCodable.self, forKey: .officialArtwork)
        self.showdown = try container.decode(ShowdownArtworkSpritesCodable.self, forKey: .showdown)
    }
    
    // MARK: - INITIALIZERS
    init(officialArtwork: OfficialArtworkSpritesCodable, showdown: ShowdownArtworkSpritesCodable) {
        self.officialArtwork = officialArtwork
        self.showdown = showdown
    }
}
