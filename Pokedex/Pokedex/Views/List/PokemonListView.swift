//
//  PokemonList.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct PokemonListView: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        NavigationStack {
            List {
                ForEach(manager.selectedIndices, id:\.self) { i in
                    NavigationLink(destination: { PokemonDetailsView(pokemon: $manager.pokemon[i]) }) {
                        PokemonRowView(pokemon: manager.pokemon[i])
                    }
                }
            }
            .listStyle(.plain)
            .navigationTitle("Pokédex")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement:.navigationBarTrailing) {
                    Picker(selection: $manager.selectedType, label: Text("Type")) {
                        Text("All Types").tag(nil as PokemonType?)
                        ForEach(PokemonType.allCases) { type in
                            Text(type.rawValue).tag(type as PokemonType?)
                        }
                    }
                }
            }
        }
    }
}
