//
//  PokemonSummaryViewModelTests.swift
//  SamplePokemonAppTests
//
//  Created by Heshantha Don on 13/06/2024.
//

import XCTest
@testable import SamplePokemonApp

final class PokemonSummaryViewModelTests: XCTestCase {
    // MARK: - PROPERTIES
    private var sut: PokemonSummaryView.Model!
    private var mng: MocNetworkManager!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mng = MocNetworkManager()
        sut = PokemonSummaryView.Model(pokemon: MocPokemon.pikachu.binding(set: { _ in }), service: PokemonService(manager: mng))
    }

    override func tearDownWithError() throws {
        mng = nil
        sut = nil
        try super.tearDownWithError()
    }
    
    // MARK: - TEST CASES
    func testCalculateStatPercentageSuccess() async {
        let baseStat = 53
        let maxBaseStat = 255
        
        let percentage = await sut.calculateStatPercentage(baseStat: baseStat, maxBaseStat: maxBaseStat)
        XCTAssertEqual(percentage, 20.7843132)
    }
    
    func testCalculateStatPercentageFailer() async {
        let baseStat = 53
        let maxBaseStat = 255
        
        let percentage = await sut.calculateStatPercentage(baseStat: baseStat, maxBaseStat: maxBaseStat)
        XCTAssertNotEqual(percentage, 0)
    }
}
