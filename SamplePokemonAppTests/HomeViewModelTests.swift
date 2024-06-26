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
    private var sut: HomeView.Model!
    private var mng: MocNetworkManager!
    private var dbmng: MocPokemonDatabaseManager!
    private var cancellable: Cancellables!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mng = MocNetworkManager()
        dbmng = MocPokemonDatabaseManager()
        sut = HomeView.Model(service: PokemonService(networkManager: mng,
                                                     databaseManager: dbmng))
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
            try await sut.fetchData()
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
            try await sut.fetchData()
            try await Task.sleep(for: .seconds(3))
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testAddToFavoritesSuccess() async throws {
        // Given
        await mng.set(shouldReturnError: false)
        dbmng.failAddFavorite = false
        dbmng.failDeleteFavorite = false
        let pokemon = MocPokemon.pikachu
        
        // When
        try await sut.removeFromFavorites(pokemon)
        try await sut.addToFavorites(pokemon)
        if let tPokemon = sut.pokemons.filter( { $0.id == pokemon.id } ).first {
            // Then
            XCTAssertEqual(tPokemon.isFavorite, true)
        }
    }
    
    func testAddToFavoritesFailure() async throws {
        // Given
        await mng.set(shouldReturnError: false)
        dbmng.failAddFavorite = true
        dbmng.failDeleteFavorite = false
        let pokemon = MocPokemon.pikachu
        
        // When
        try await sut.removeFromFavorites(pokemon)
        try await sut.addToFavorites(pokemon)
        if let tPokemon = sut.pokemons.filter( { $0.id == pokemon.id } ).first {
            // Then
            XCTAssertNotEqual(tPokemon.isFavorite, true)
        }
    }
    
    func testRemoveFromFavoritesSuccess() async throws {
        // Given
        await mng.set(shouldReturnError: false)
        dbmng.failAddFavorite = false
        dbmng.failDeleteFavorite = false
        let pokemon = MocPokemon.pikachu
        
        // When
        try await sut.addToFavorites(pokemon)
        try await sut.removeFromFavorites(pokemon)
        if let tPokemon = sut.pokemons.filter( { $0.id == pokemon.id } ).first {
            // Then
            XCTAssertEqual(tPokemon.isFavorite, false)
        }
    }
    
    func testRemoveFromFavoritesFailure() async throws {
        // Given
        await mng.set(shouldReturnError: false)
        dbmng.failAddFavorite = false
        dbmng.failDeleteFavorite = true
        let pokemon = MocPokemon.pikachu
        
        // When
        try await sut.addToFavorites(pokemon)
        try await sut.removeFromFavorites(pokemon)
        if let tPokemon = sut.pokemons.filter( { $0.id == pokemon.id } ).first {
            // Then
            XCTAssertNotEqual(tPokemon.isFavorite, false)
        }
    }
    
    func testLoadRemainingFavoritesSuccess() async throws {
        // Given
        await mng.set(shouldReturnError: false)
        await mng.set(withoutSquirtle: true)
        let pokemon = MocPokemon.squirtle
        
        // When
        dbmng.failAddFavorite = false
        dbmng.failDeleteFavorite = false
        try await sut.addToFavorites(pokemon)
        try await sut.loadRemainingFavorites()
        if let tPokemon = sut.pokemons.filter( { $0.id == pokemon.id } ).first {
            // Then
            XCTAssertEqual(tPokemon.isFavorite, true)
        }
    }
    
    func testLoadRemainingFavoritesFailure() async throws {
        // Given
        await mng.set(shouldReturnError: false)
        await mng.set(withoutSquirtle: true)
        let pokemon = MocPokemon.squirtle
        
        // When
        dbmng.failAddFavorite = false
        dbmng.failDeleteFavorite = false
        try await sut.removeFromFavorites(pokemon)
        try await sut.loadRemainingFavorites()
        if let tPokemon = sut.pokemons.filter( { $0.id == pokemon.id } ).first {
            // Then
            XCTAssertNotEqual(tPokemon.isFavorite, true)
        }
    }
    
    @MainActor
    func testSearchPokemonByNameSuccess() async {
        let pokemonName = MocPokemon.POKEMON_NAME.PIKACHU
        
        do {
            try await sut.fetchData()
            try await Task.sleep(for: .seconds(3))
            let pokemons = sut.searchPokemon(by: pokemonName)
            
            XCTAssertNotNil(pokemons)
            if pokemons.count == 1 {
                XCTAssertEqual(pokemonName, pokemons[0].name)
            } else {
                XCTFail("Expected only one item in the array but found more")
            }
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    @MainActor
    func testSearchPokemonByNameFailer() async {
        let pokemonName = "NOT A POKEMON NAME"
        
        do {
            try await sut.fetchData()
            try await Task.sleep(for: .seconds(3))
            let pokemons = sut.searchPokemon(by: pokemonName)
            
            XCTAssertNotNil(pokemons)
            XCTAssertEqual(pokemons.count, 0)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    @MainActor
    func testSearchPokemonByEmptyNameSuccess() async {
        let pokemonName = ""
        
        do {
            try await sut.fetchData()
            try await Task.sleep(for: .seconds(3))
            let pokemons = sut.searchPokemon(by: pokemonName)
            
            XCTAssertNotNil(pokemons)
            XCTAssertGreaterThan(pokemons.count, 1)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    @MainActor
    func testSearchPokemonByEmptyNameFailer() async {
        let pokemonName = ""
        
        do {
            try await sut.fetchData()
            try await Task.sleep(for: .seconds(3))
            let pokemons = sut.searchPokemon(by: pokemonName)
            
            XCTAssertNotNil(pokemons)
            XCTAssertNotEqual(pokemons.count, 1)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    // MARK: - TEST CASES
    func testSearchPokemonFromServiceByNameSuccess() async {
        await mng.set(shouldReturnError: false)
        let pokemonName = MocPokemon.POKEMON_NAME.PIKACHU
        let expectation = XCTestExpectation(description: "Search Pokémon from service succeeds")
        sut.$pokemons
            .dropFirst()
            .sink { pokemons in
                if pokemons.count > 0 {
                    let newPokemons = pokemons.filter( { $0.name == pokemonName } )
                    XCTAssertGreaterThan(newPokemons.count, 0)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        do {
            try await sut.searchPokemonFromService(by: pokemonName)
            await fulfillment(of: [expectation], timeout: 5)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
    
    func testSearchPokemonFromServiceByNameFailer() async {
        await mng.set(shouldReturnError: false)
        let pokemonName = "NOT A POKEMON NAME"
        let expectation = XCTestExpectation(description: "Search Pokémon from service failed : Test succeeds")
        sut.$pokemons
            .dropFirst()
            .sink { pokemons in
                if pokemons.count > 0 {
                    let newPokemons = pokemons.filter( { $0.name == pokemonName } )
                    XCTAssertEqual(newPokemons.count, 0)
                    expectation.fulfill()
                }
            }
            .store(in: &cancellable)
        
        do {
            try await sut.searchPokemonFromService(by: pokemonName)
            await fulfillment(of: [expectation], timeout: 5)
        } catch {
            XCTFail("Expected success but got error: \(error)")
        }
    }
}
