//
//  LinearGradient+Pokemon.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import Foundation
import SwiftUI

extension LinearGradient {
    init(pokemon: Pokemon) {
        let gradient = LinearGradient(colors: pokemon.types.map({ Color(pokemonType: $0) }), startPoint: .topLeading, endPoint: .bottomTrailing)
        self = gradient;
    }
}
