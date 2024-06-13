//
//  PokemonDecodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

struct PokemonDecodable: Decodable {
    // MARK: - PROPERTIES
    let `id`: Int
    var name: String
    var `height`: Int
    var species: PokemonSpeciesDecodable
    var sprites: SpritesDecodable
    var abilities: [AbilitiesDecodable]
    var stats: [StatsDecodable]
    var weight: Int
    
    enum CodingKeys: CodingKey {
        case id
        case name
        case height
        case species
        case sprites
        case abilities
        case stats
        case weight
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.height = try container.decode(Int.self, forKey: .height)
        self.species = try container.decode(PokemonSpeciesDecodable.self, forKey: .species)
        self.sprites = try container.decode(SpritesDecodable.self, forKey: .sprites)
        self.abilities = try container.decode([AbilitiesDecodable].self, forKey: .abilities)
        self.stats = try container.decode([StatsDecodable].self, forKey: .stats)
        self.weight = try container.decode(Int.self, forKey: .weight)
    }
    
    init(id: Int, name: String, height: Int, species: PokemonSpeciesDecodable, sprites: SpritesDecodable, abilities: [AbilitiesDecodable], stats: [StatsDecodable], weight: Int) {
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

extension PokemonDecodable {
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


