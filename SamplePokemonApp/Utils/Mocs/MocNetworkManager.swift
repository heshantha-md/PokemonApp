//
//  MocNetworkManager.swift
//  SamplePokemonAppTests
//
//  Created by Heshantha Don on 08/06/2024.
//

actor MocNetworkManager: NetworkManagerProtocal
{
    // MARK: - PROPERTIES
    let pokemons: [String: PokemonDecodable] = [MocPokemon.POKEMON_NAME.PIKACHU : MocPokemon.pikachuDecodable,
                                                MocPokemon.POKEMON_NAME.MEW : MocPokemon.mewDecodable,
                                                MocPokemon.POKEMON_NAME.SQUIRTLE : MocPokemon.squirtleDecodable]
    
    let pokemonSpecies: [String: PokemonSpeciesDetailDecodable] = [MocPokemon.POKEMON_NAME.PIKACHU : MocPokemon.pikachuSpeciesDetailDecodable,
                                                MocPokemon.POKEMON_NAME.MEW : MocPokemon.mewSpeciesDetailDecodable,
                                                MocPokemon.POKEMON_NAME.SQUIRTLE : MocPokemon.squirtleSpeciesDetailDecodable]
    
    private let pokemonsResponse: PokemonsResponseDecodable = PokemonsResponseDecodable(count: 3,
                                                                                        results: [PokemonResponseDecodable(name: MocPokemon.POKEMON_NAME.PIKACHU, url: "\(Constants.URLS.POKEMONS_BASE_URL)/\(MocPokemon.POKEMON_NAME.PIKACHU.lowercased())"),
                                                                   PokemonResponseDecodable(name: MocPokemon.POKEMON_NAME.MEW, url: "\(Constants.URLS.POKEMONS_BASE_URL)/\(MocPokemon.POKEMON_NAME.MEW.lowercased())"),
                                                                   PokemonResponseDecodable(name: MocPokemon.POKEMON_NAME.SQUIRTLE, url: "\(Constants.URLS.POKEMONS_BASE_URL)/\(MocPokemon.POKEMON_NAME.SQUIRTLE.lowercased())")])
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
        case .getFrom(let url):
            if url.contains("pokemon-species") {
                if shouldReturnError { return nil }
                if url.contains("25") {
                    return pokemonSpecies[MocPokemon.POKEMON_NAME.PIKACHU] as? T
                } else if url.contains("151") {
                    return pokemonSpecies[MocPokemon.POKEMON_NAME.MEW] as? T
                }
                return pokemonSpecies[MocPokemon.POKEMON_NAME.SQUIRTLE] as? T
            } else {
                if shouldReturnError { return nil }
                if url.contains(MocPokemon.POKEMON_NAME.PIKACHU.lowercased()) {
                    return pokemons[MocPokemon.POKEMON_NAME.PIKACHU] as? T
                } else if url.contains(MocPokemon.POKEMON_NAME.MEW.lowercased()) {
                    return pokemons[MocPokemon.POKEMON_NAME.MEW] as? T
                }
                return pokemons[MocPokemon.POKEMON_NAME.SQUIRTLE] as? T
            }
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
