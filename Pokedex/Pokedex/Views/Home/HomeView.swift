//
//  HomeView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 11/9/22.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        NavigationStack {
            ScrollView {
                if(!manager.captured.isEmpty) {
                    CardRowView(title: "Captured", indices: manager.captured)
                }
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

