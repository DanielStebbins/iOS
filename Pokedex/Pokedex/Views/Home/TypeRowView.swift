//
//  TypeRowView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 11/9/22.
//

import SwiftUI

struct TypeRowView: View {
    @EnvironmentObject var manager: Manager
    let type: PokemonType
    var body: some View {
        CardRowView(title: type.rawValue, indices: manager.indicesForType(type), color: Color(pokemonType: type), uniformBackground: true)
    }
}
