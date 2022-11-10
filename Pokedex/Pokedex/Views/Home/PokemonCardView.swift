//
//  PokemonCardView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 11/9/22.
//

import SwiftUI

struct PokemonCardView: View {
    let pokemon: Pokemon
    let background: Color
    var body: some View {
        VStack(alignment: .center) {
            PokemonImageView(pokemon: pokemon, size: 75, round: 20)
            Text("\(pokemon.id)")
            Text(pokemon.name)
                .font(.title2)
        }
        .padding(7)
        .background(background)
        .clipShape(RoundedRectangle(cornerRadius: 20))
        .padding(.leading, 7)
    }
}
