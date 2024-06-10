//
//  HomeViewModel.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import Foundation

final class HomeViewModel: ObservableObject {
    // MARK: - PROPERTIES
    @Published var pokemons: Pokemons = [] {
        didSet {
            objectWillChange.send()
        }
    }
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
    /// This function to fetch Pokemon data using Pokemon Service (aka PokemonService)
    ///
    /// - returns: Will be monitoring the the returning data using 'subscribe' function
    func fetchData() throws {
        Task(priority: .background) {
            try await service?.fetchData()
        }
    }
    
    /// This function will monitor Pokemon Service (aka PokemonService) property changes
    ///
    /// - returns: Will be publising the the returned data using internal 'pokemons' property
    private func subscribe() {
        service?.$pokemons
            .removeDuplicates()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] pokemons in
                self?.pokemons = pokemons
            }
            .store(in: &cancellables)
    }
}
