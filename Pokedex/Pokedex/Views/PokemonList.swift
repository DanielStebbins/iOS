//
//  PokemonList.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct PokemonList: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        NavigationStack {
            List {
                ForEach(manager.model.pokemon) { pokemon in
                    NavigationLink(destination: { PokemonDetails(pokemon: pokemon) }) {
                        PokemonRow(pokemon: pokemon)
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokédex")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
