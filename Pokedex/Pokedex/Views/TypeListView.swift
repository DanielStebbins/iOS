//
//  TypeListView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct TypeListView: View {
    let title: String
    let types: [PokemonType]
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .fontWeight(.bold)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(types) { type in
                        Text(type.rawValue)
                            .padding([.leading, .trailing], 6)
                            .padding([.top, .bottom], 4)
                            .foregroundColor(.white)
                            .background {
                                Capsule()
                                    .fill(Color(pokemonType: type))
                            }
                    }
                }
            }
        }
        .padding()
    }
}
