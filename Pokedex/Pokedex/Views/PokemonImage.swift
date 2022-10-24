//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct PokemonImage: View {
    let pokemon: Pokemon
    let size: CGSize
    var body: some View {
        Image(pokemon.leadingZeroID)
            .resizable()
            .frame(width: size.width, height: size.height)
            .background(LinearGradient(pokemon: pokemon))
            .clipShape(RoundedRectangle(cornerRadius: size.width / 4))
    }
}
