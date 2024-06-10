//
//  HomeViewModel.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    // MARK: - PROPERTIES
    @Published var pokemons: Pokemons = []
    private var pokemonsTemp: Pokemons = []
    private var service: PokemonService?
    private var cancellables: Cancellables = []
    
    // MARK: - INITIALIZERS
    private init() {} // Making default initializer function inaccessible as Pokemon Service (aka PokemonService) typed object mandatory to function this class
    convenience init(service: PokemonService) {
        self.init()
        self.service = service
        self.subscribe()
    }
    
    // MARK: - FUNCTIONS
    /// This function to fetch Pokémon data using Pokémon Service (aka PokemonService)
    ///
    /// - returns: Will be monitoring the the returning data using 'subscribe' function
    func fetchData() throws {
        Task(priority: .background) {
            try await service?.fetchData()
        }
    }
    
    /// This function will look for specific Pokémon using an API service by their names
    ///
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    @MainActor
    func searchPokemonFromService(by name: String) async {
        if pokemonsTemp.count < pokemons.count {
            pokemonsTemp = pokemons
        }
        
        do {
            try await service?.fetchData(by: name.lowercased())
        } catch {
            print(error.localizedDescription)
            //TODO: - Need to Handle the error
        }
    }
    
    /// This function will filter specific Pokémon by their names.
    ///
    /// - returns: A List of Pokemon objects with all the related data of the Pokémon
    @MainActor
    func searchPokemon(by name: String) -> PokemonsArr {
        if name.isEmpty {
            return pokemons.sorted()
        }
        return pokemons.filter { $0.name.lowercased()
                       .hasPrefix(name.lowercased()) }
                       .sorted(by: <)
    }
    
    // MARK: - PRIVATE FUNCTIONS
    /// This function will monitor Pokémon Service (aka PokemonService) property changes
    ///
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    private func subscribe() {
        Task {
            await MainActor.run {
                service?.$pokemons
                    .removeDuplicates()
                    .receive(on: DispatchQueue.main)
                    .sink { [weak self] pokemons in
                        self?.pokemons = pokemons
                    }
                    .store(in: &cancellables)
            }
        }
    }
}
