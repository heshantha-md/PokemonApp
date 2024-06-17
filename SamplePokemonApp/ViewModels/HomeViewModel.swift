//
//  HomeViewModel.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation
import SwiftData

extension HomeView {
    final class Model: ObservableObject {
        // MARK: - PROPERTIES
        @Published var pokemons: Pokemons = [] {
            didSet {
                if isSearching {
                    isSearching.toggle()
                    return
                }
                
                offset = pokemons.count
            }
        }
        @Published var error: ViewError?
        private var offset: Int = 0
        private var pokemonsTemp: Pokemons = []
        private var service: PokemonService?
        private var cancellables: Cancellables = []
        private var fetchTask: Task<Void, Never>?
        private var isSearching: Bool = false
        
        // MARK: - INITIALIZERS
        private init() {} // Making default initializer function inaccessible as Pokemon Service (aka PokemonService) type object mandatory to function this class
        convenience init(service: PokemonService) {
            self.init()
            self.service = service
            self.subscribe()
        }
        
        // MARK: - FUNCTIONS
        /// This function to fetch Pokémon data using Pokémon Service (aka PokemonService).
        /// - returns: Will be monitoring the the returning data using 'subscribe' function.
        @NetworkActor
        func fetchData() throws {
            fetchTask?.cancel()
            fetchTask = Task(priority: .userInitiated) {
                do {
                    try await self.service?.fetchData(offset: self.offset)
                } catch  {
                    self.error = ViewError.badPokemonFetchDataResponse(error: error.localizedDescription)
                }
            }
        }
        
        /// This function will look for specific Pokémon using an API service by their names.
        /// - returns: Will be publising the the returned data using internal 'pokemons' property.
        @NetworkActor
        func searchPokemonFromService(by name: String) throws {
            fetchTask?.cancel()
            fetchTask = Task(priority: .high) {
                do {
                    isSearching = true
                    try await self.service?.fetchPokemon(by: name)
                } catch {
                    self.error = ViewError.badResponseForSearchPokemonFromService(error: error.localizedDescription)
                }
            }
        }
        
        /// This function will filter specific Pokémon by their names.
        /// - returns: A List of Pokemon objects with all the related data of the Pokémon.
        @MainActor
        func searchPokemon(by name: String) -> PokemonsArr {
            if name.isEmpty {
                return pokemons.sorted()
            }
            
            if self.pokemons.count < self.pokemonsTemp.count {
                self.pokemons = self.pokemonsTemp
            } else {
                self.pokemonsTemp = self.pokemons
            }
            
            return pokemons.filter { $0.name.lowercased()
                           .hasPrefix(name.lowercased()) }
                           .sorted(by: <)
        }
        
        /// This function will add a specified Pokémon to the user's list of favorites using the service provided.
        /// - parameter pokemon: A 'Pokemon' object representing the Pokémon to be added to the favorites.
        /// - warning: This function executes the addition with high priority and performs the operation asynchronously.
        /// - returns: Will be publising the the returned data using internal 'pokemons' property.
        @DatabaseActor
        func addToFavorites(_ pokemon: Pokemon) async throws {
            Task(priority: .high) {
                do {
                    try await service?.addToFavorites(pokemon)
                } catch {
                    throw ViewError.failedToMakePokemonFavorite
                }
            }
        }
        
        // MARK: - PRIVATE FUNCTIONS
        /// This function will monitor Pokémon Service (aka PokemonService) property changes.
        /// - returns: Will be publising the the returned data using internal 'pokemons' property.
        private func subscribe() {
            service?.$pokemons
                .removeDuplicates()
                .receive(on: DispatchQueue.main)
                .sink { [weak self] newValue in
                    self?.pokemons = newValue
                }
                .store(in: &cancellables)
        }
    }
}
