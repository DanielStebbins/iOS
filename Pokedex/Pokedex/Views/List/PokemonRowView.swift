//
//  ContentView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct PokemonRowView: View {
    let pokemon: Pokemon
    var body: some View {
        HStack {
            Text("\(pokemon.id)")
                .foregroundColor(.gray)
                .padding(.leading, 10)
            Text(pokemon.name)
                .font(.title2)
            Image(pokemon.captured! ? "Pokeball" : "EmptyPokeball")
                .resizable()
                .frame(width: 20, height: 20)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            Spacer()
            PokemonImageView(pokemon: pokemon, size: 75, round: 20)
                .padding(.trailing, 10)
        }
    }
}
