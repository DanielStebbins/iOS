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
    let size: CGFloat
    var body: some View {
        Text(manager.leadingZeroID(of: pokemon))
            .font(.system(size: size, weight: .bold, design: .monospaced))
            .padding(.trailing, size)
            .padding(.bottom, size)
    }
}
