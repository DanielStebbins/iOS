//
//  StatView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct StatView: View {
    let title: String
    let stat: String
    let units: String
    var body: some View {
        VStack {
            Text(title)
                .fontWeight(.bold)
            HStack {
                Text(stat)
                    .font(.system(size: 25, weight: .bold, design: .rounded))
                Text(units)
            }
        }
        .padding([.leading, .trailing], 20)
    }
}
