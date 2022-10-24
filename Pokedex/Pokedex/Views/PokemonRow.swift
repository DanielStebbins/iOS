//
//  ContentView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon
    var body: some View {
        HStack {
            Text("\(pokemon.id)")
                .foregroundColor(.gray)
                .padding(.leading, 10)
            Text(pokemon.name)
                .font(.title2)
            Spacer()
            PokemonImage(pokemon: pokemon, size: CGSize(width: 75, height: 75))
                .padding(.trailing, 10)
        }
    }
}
