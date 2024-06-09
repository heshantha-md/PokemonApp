//
//  OtherSprites.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 07/06/2024.
//

struct OtherSprites: Decodable {
    // MARK: - PROPERTIES
    let dreamWorld: DreamWorldSprites?
    let home: HomeSprites?
    let officialArtwork: OfficialArtworkSprites?
    let showdown: ShowdownArtworkSprites?
    
    enum CodingKeys: String, CodingKey {
        case dreamWorld = "dream_world"
        case home
        case officialArtwork = "official-artwork"
        case showdown
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.dreamWorld = try container.decodeIfPresent(DreamWorldSprites.self, forKey: .dreamWorld)
        self.home = try container.decodeIfPresent(HomeSprites.self, forKey: .home)
        self.officialArtwork = try container.decodeIfPresent(OfficialArtworkSprites.self, forKey: .officialArtwork)
        self.showdown = try container.decodeIfPresent(ShowdownArtworkSprites.self, forKey: .showdown)
    }
    
    init(dreamWorld: DreamWorldSprites?, home: HomeSprites?, officialArtwork: OfficialArtworkSprites?, showdown: ShowdownArtworkSprites?) {
        self.dreamWorld = dreamWorld
        self.home = home
        self.officialArtwork = officialArtwork
        self.showdown = showdown
    }
}
