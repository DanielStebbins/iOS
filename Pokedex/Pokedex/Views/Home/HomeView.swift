//
//  HomeView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 11/9/22.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ScrollView {
                ForEach(PokemonType.allCases) { type in
                    TypeRowView(type: type)
                }
            }
            .navigationTitle("Pokédex")
            .navigationBarTitleDisplayMode(.inline)
        }
        .buttonStyle(.plain)
    }
}

