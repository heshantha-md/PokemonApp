//
//  PokemonCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

struct PokemonCodable: Codable {
    // MARK: - PROPERTIES
    let id: Int
    var name: String
    var height: Int
    var species: PokemonSpeciesCodable
    var sprites: SpritesCodable
    var abilities: [AbilitiesCodable]
    var stats: [StatsCodable]
    var weight: Int
    
    // MARK: - INITIALIZERS
    init(id: Int, name: String, height: Int, species: PokemonSpeciesCodable, sprites: SpritesCodable, abilities: [AbilitiesCodable], stats: [StatsCodable], weight: Int) {
        self.id = id
        self.name = name
        self.height = height
        self.species = species
        self.sprites = sprites
        self.abilities = abilities
        self.stats = stats
        self.weight = weight
    }
}

extension PokemonCodable {
    /// This function will create a new Pokémon DTO (aka Pokemon) using the Pokémon Decodable DTO (aka PokemonDecodable). The Pokémon DTO will contain all the Pokémon-related information and work with views to load and modify Pokémon data.
    /// - returns: 'Pokemon' type Pokémon object
    func asPokemon() -> Pokemon {
        let abilities = abilities.map { Ability(name: $0.ability.name) }
        
        return Pokemon(id: id,
                       name: name.replacingOccurrences(of: "-", with: " "),
                       height: height,
                       weight: weight,
                       species: Species(name: species.name, url: species.url),
                       sprites: Sprites(officialArtwork: OfficialArtworkSprites(frontShiny: sprites.other.officialArtwork.frontShiny,
                                                                                backShiny: sprites.other.officialArtwork.backShiny),
                                        showdown: ShowdownArtworkSprites(frontShiny: sprites.other.showdown.frontShiny,
                                                                         backShiny: sprites.other.showdown.backShiny)),
                       abilities: abilities,
                       stat: getStats())
    }
    
    /// This function will create a new Pokémon Stat DTO (aka Stat) using the Pokémon Decodable DTO (aka PokemonDecodable). Stats are the six primary factors that determine how a Pokémon will perform in battle. They are HP, Attack, Defense, Special Attack, Special Defense, and Speed.
    /// - returns: 'Stat' type Pokémon Stat object
    func getStats() -> Stat {
        var hp = 0
        var attack = 0
        var defense = 0
        var specialAttack = 0
        var specialDefense = 0
        var speed = 0
        
        stats.forEach {
            switch $0.stat.name {
            case "hp": hp = $0.baseStat
            case "attack": attack = $0.baseStat
            case "defense": defense = $0.baseStat
            case "special-attack": specialAttack = $0.baseStat
            case "special-defense": specialDefense = $0.baseStat
            case "speed": speed = $0.baseStat
            default: break
            }
        }
        
        return Stat(hp: hp,
                    attack: attack,
                    defense: defense,
                    specialAttack: specialAttack,
                    specialDefense: specialDefense,
                    speed: speed)
    }
}


