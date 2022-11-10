//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct PokemonDetailsView: View {
    @EnvironmentObject var manager: Manager
    @Binding var pokemon: Pokemon
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                PokemonImageView(pokemon: pokemon, size: 365, round: 25)
                    .overlay(alignment: .bottomTrailing) {
                        IDOverlayView(pokemon: pokemon, size: 20)
                    }
                    .padding(.top, 20)
                HStack {
                    StatView(title: "Height", stat: manager.formatHeight(of: pokemon), units: "m")
                    StatView(title: "Weight", stat: manager.formatWeight(of: pokemon), units: "kg")
                    Button(action: { pokemon.captured!.toggle() }) {
                        Image(pokemon.captured! ? "Pokeball" : "EmptyPokeball")
                            .resizable()
                            .frame(width: 75, height: 75)
                            .clipShape(RoundedRectangle(cornerRadius: 50))
                    }
                }
                TypeListView(title: "Types", types: pokemon.types)
                TypeListView(title: "Weaknesses", types: pokemon.weaknesses)
                if (pokemon.prevEvolution != nil) {
                    CardRowView(title: "Evolves From", indices: manager.indicesForIDs(pokemon.prevEvolution!), color: .black, uniformBackground: false)
                }
                if (pokemon.nextEvolution != nil) {
                    CardRowView(title: "Evolves To", indices: manager.indicesForIDs(pokemon.nextEvolution!), color: .black, uniformBackground: false)
                }
            }
            .buttonStyle(.plain)
            .navigationTitle(pokemon.name)
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
