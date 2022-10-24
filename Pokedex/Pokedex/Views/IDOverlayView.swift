//
//  IDOverlayView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

struct IDOverlayView: View {
    @EnvironmentObject var manager: Manager
    let pokemon: Pokemon
    var body: some View {
        Text(manager.leadingZeroID(of: pokemon))
            .font(.system(size: 20, weight: .bold, design: .monospaced))
            .padding(.trailing, 15)
            .padding(.bottom, 10)
    }
}
