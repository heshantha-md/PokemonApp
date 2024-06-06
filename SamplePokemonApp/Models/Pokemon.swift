//
//  Pokemon.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

struct Pokemon: Decodable {
    let sprites: PokemonSprites
    
    enum CodingKeys: CodingKey {
        case sprites
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.sprites = try container.decode(PokemonSprites.self, forKey: .sprites)
    }
}

struct PokemonSprites: Decodable {
    let back_default: String?
    let back_female: String?
    let back_shiny: String?
    let back_shiny_female: String?
    let front_default: String?
    let front_female: String?
    let front_shiny: String?
    let front_shiny_female: String?
    
    enum CodingKeys: CodingKey {
        case back_default
        case back_female
        case back_shiny
        case back_shiny_female
        case front_default
        case front_female
        case front_shiny
        case front_shiny_female
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.back_default = try container.decodeIfPresent(String.self, forKey: .back_default)
        self.back_female = try container.decodeIfPresent(String.self, forKey: .back_female)
        self.back_shiny = try container.decodeIfPresent(String.self, forKey: .back_shiny)
        self.back_shiny_female = try container.decodeIfPresent(String.self, forKey: .back_shiny_female)
        self.front_default = try container.decodeIfPresent(String.self, forKey: .front_default)
        self.front_female = try container.decodeIfPresent(String.self, forKey: .front_female)
        self.front_shiny = try container.decodeIfPresent(String.self, forKey: .front_shiny)
        self.front_shiny_female = try container.decodeIfPresent(String.self, forKey: .front_shiny_female)
    }
}
