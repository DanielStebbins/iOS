//
//  PokemonDetails.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct PokemonDetails: View {
    let pokemon: Pokemon
    var body: some View {
        PokemonRow(pokemon: pokemon)
    }
}
