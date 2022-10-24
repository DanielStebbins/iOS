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
//        ZStack {
//            RoundedRectangle(cornerRadius: size.width / 4)
//                .fill(LinearGradient(pokemon: pokemon))
//                .overlay {
//                    Image(pokemon.leadingZeroID)
//                        .resizable()
//                        .scaledToFit()
//                        .padding(3)
//                }
//        }
//        .frame(width: size.width, height: size.height)
        Image(pokemon.leadingZeroID)
            .resizable()
            .frame(width: size.width, height: size.height)
            .background(LinearGradient(pokemon: pokemon))
            .padding(3)
            .clipShape(RoundedRectangle(cornerRadius: size.width / 4))
    }
}
