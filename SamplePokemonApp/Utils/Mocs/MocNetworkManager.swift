//
//  MocNetworkManager.swift
//  SamplePokemonAppTests
//
//  Created by Heshantha Don on 08/06/2024.
//

actor MocNetworkManager: NetworkManagerProtocal
{
    // MARK: - PROPERTIES
    let pokemons: PokemonsDict = [MocPokemon.POKEMON_NAME.PIKACHU : MocPokemon.pikachu,
                            MocPokemon.POKEMON_NAME.MEW : MocPokemon.mew,
                            MocPokemon.POKEMON_NAME.SQUIRTLE : MocPokemon.squirtle]
    private let pokemonsResponse: PokemonsResponseModel = PokemonsResponseModel(count: 3,
                                                         results: [PokemonResponseModel(name: MocPokemon.POKEMON_NAME.PIKACHU, url: "\(Constants.URLS.POKEMONS_BASE_URL)/\(MocPokemon.POKEMON_NAME.PIKACHU)"),
                                                                   PokemonResponseModel(name: MocPokemon.POKEMON_NAME.MEW, url: "\(Constants.URLS.POKEMONS_BASE_URL)/\(MocPokemon.POKEMON_NAME.MEW)"),
                                                                   PokemonResponseModel(name: MocPokemon.POKEMON_NAME.SQUIRTLE, url: "\(Constants.URLS.POKEMONS_BASE_URL)/\(MocPokemon.POKEMON_NAME.SQUIRTLE)")])
    var shouldReturnError: Bool = false
    
    // MARK: - FUNCTIONS
    /// Mocked Generic API call function to fetch data
    ///
    /// - parameter endpoint: Api endpoint information
    /// - returns: Generic type representation of the results
    func fetchData<T>(_ endpoint: ApiEndPoint) async throws -> T? where T : Decodable {
        try await Task.sleep(for: .seconds(0.5))
        switch endpoint {
        case .getPokemons(_):
            return shouldReturnError ? nil : pokemonsResponse as? T
        case .getPokemon(let name):
            return shouldReturnError ? nil : (pokemons[name] ?? pokemons.randomElement()?.value) as? T
        }
    }
    
    /// This function will update 'shouldReturnError' property value.
    ///
    /// - parameter shouldReturnError: 'True' or 'False' value to indicate whether Moc service (aka MocNetworkManager) should return valid results or not in-order to support Unit Testing
    func set(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }
}
