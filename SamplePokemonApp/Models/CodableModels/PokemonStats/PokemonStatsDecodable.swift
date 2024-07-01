//
//  StatsCodable.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 11/06/2024.
//

struct StatsCodable: Codable {
    // MARK: - PROPERTIES
    var baseStat: Int
    var stat: StatCodable
    
    enum CodingKeys: String, CodingKey {
        case baseStat = "base_stat"
        case stat
    }
    
    // MARK: - ENCODING
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(baseStat, forKey: .baseStat)
        try container.encode(stat, forKey: .stat)
    }
    
    // MARK: - DECODING
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseStat = try container.decode(Int.self, forKey: .baseStat)
        self.stat = try container.decode(StatCodable.self, forKey: .stat)
    }
    
    // MARK: - INITIALIZERS
    init(baseStat: Int, stat: StatCodable) {
        self.baseStat = baseStat
        self.stat = stat
    }
}
