//
//  HomeViewModelTests.swift
//  SamplePokemonAppTests
//
//  Created by Heshantha Don on 08/06/2024.
//

import XCTest
@testable import SamplePokemonApp

final class HomeViewModelTests: XCTestCase {
    // MARK: - PROPERTIES
    private var sut: HomeViewModel!
    private var mng: MocNetworkManager!
    private var cancellable: Cancellables!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mng = MocNetworkManager()
        sut = HomeViewModel(service: PokemonService(manager: mng))
        cancellable = []
    }

    override func tearDownWithError() throws {
        mng = nil
        sut = nil
        cancellable = nil
        try super.tearDownWithError()
    }

    // MARK: - TEST CASES
    func testFetchDataFromPokemonServiceSuccess() async {
        await mng.set(shouldReturnError: false)
        let expectation = XCTestExpectation(description: "Data fetch succeeds")
        sut.$pokemons
            .dropFirst()
            .sink { pokemons in
                if pokemons.count > 0 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        do {
            try sut.fetchData()
            await fulfillment(of: [expectation], timeout: 5)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testFetchDataFromPokemonServiceFailer() async {
        await mng.set(shouldReturnError: true)
        sut.$pokemons
            .dropFirst()
            .sink { pokemons in
                if pokemons.count > 0 {
                    XCTFail("Expected failure but succeeded")
                }
            }
            .store(in: &cancellable)
        
        do {
            try sut.fetchData()
            try await Task.sleep(for: .seconds(3))
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
}
