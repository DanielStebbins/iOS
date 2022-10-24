//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    @EnvironmentObject var manager: Manager
    let pokemon: Pokemon
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                PokemonImageView(pokemon: pokemon, size: 365, round: 25)
                    .overlay(alignment: .bottomTrailing) {
                        IDOverlayView(pokemon: pokemon)
                    }
                    .padding(.top, 20)
                HStack {
                    StatView(title: "Height", stat: manager.formatHeight(of: pokemon), units: "m")
                    StatView(title: "Weight", stat: manager.formatWeight(of: pokemon), units: "kg")
                }
                TypeListView(title: "Types", types: pokemon.types)
                TypeListView(title: "Weaknesses", types: pokemon.weaknesses)
                
            }
            .navigationTitle(pokemon.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
