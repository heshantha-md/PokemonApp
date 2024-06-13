//
//  PokemonStatsDecodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

struct StatsDecodable: Decodable {
    // MARK: - PROPERTIES
    var baseStat: Int
    var stat: StatDecodable
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
    
    // MARK: - INITIALIZERS
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseStat = try container.decode(Int.self, forKey: .baseStat)
        self.stat = try container.decode(StatDecodable.self, forKey: .stat)
    }
    
    init(baseStat: Int, stat: StatDecodable) {
        self.baseStat = baseStat
        self.stat = stat
    }
}
