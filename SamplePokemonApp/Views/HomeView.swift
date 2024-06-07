//
//  ContentView.swift
//  SamplePokemonApp
//
//  Created by Heshantha Don on 06/06/2024.
//

import SwiftUI

struct HomeView: View {
    // MARK: - Testing
    /// Testing code starts
    @State var result: PokemonsResponseModel?
    @State var ditto: Pokemon?
    
    // MARK: - BODY
    var body: some View {
        Text("foo count: \(String(describing: result?.results.count))")
            .task {
                do {
                    self.result = try await NetworkManager().fetch(.getPokemons(offset: 0))
                } catch {
                    print(error.localizedDescription)
                }
            }
        
        Text("foo: \(String(describing: ditto?.sprites.other?.dreamWorld?.frontDefault))")
            .task {
                do {
                    self.ditto = try await NetworkManager().fetch(.getPokemon(name: "beedrill"))
                } catch {
                    print(error.localizedDescription)
                }
            }
    }
    /// Testing code ends
}

// MARK: - PREVIEW
#Preview {
    HomeView()
}
