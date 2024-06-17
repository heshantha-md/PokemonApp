//
//  Set+Extensions.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 17/06/2024.
//

extension Set {
    func difference(from other: Set<Element>) -> [Element] {
        return Array(self.symmetricDifference(other))
    }
}
