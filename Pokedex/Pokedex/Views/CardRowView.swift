//
//  CardRowView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 11/9/22.
//

import SwiftUI

struct CardRowView: View {
    @EnvironmentObject var manager: Manager
    let title: String
    let indices: [Int]
    var color: Color = Color(UIColor.label)
    var uniformBackground: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .padding(.leading, 15)
                .foregroundColor(color)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(indices, id:\.self) { i in
                        NavigationLink(destination: PokemonDetailsView(pokemon: $manager.pokemon[i], closeOnRelease: true)) {
                            PokemonCardView(pokemon: manager.pokemon[i], background: uniformBackground ? color.opacity(0.5) : Color(pokemonType: manager.pokemon[i].types[0]).opacity(0.5))
                        }
                    }
                }
            }
        }
    }
}
