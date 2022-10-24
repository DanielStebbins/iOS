//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct PokemonImageView: View {
    @EnvironmentObject var manager: Manager
    let pokemon: Pokemon
    let size: Double
    let round: Double
    var body: some View {
        Image(manager.leadingZeroID(of: pokemon))
            .resizable()
            .padding(size / 10)
            .frame(width: size, height: size)
            .background(LinearGradient(pokemon: pokemon))
            .clipShape(RoundedRectangle(cornerRadius: round))
    }
}
