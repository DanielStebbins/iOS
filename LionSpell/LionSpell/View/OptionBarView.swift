//
//  OptionBarView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

// Displays the 3 option buttons: preferences, hint, and new game.
struct OptionBarView: View {
    @EnvironmentObject var gameManager: GameManager
    @Binding var showing: Showing?
    var body: some View {
        HStack {
            OptionButtonView(sfName: "gearshape.fill", action: { showing = .preferences })
            OptionButtonView(sfName: "questionmark.circle", action: { showing = .hints})
            OptionButtonView(sfName: "plus.circle", action: gameManager.newGameButtonPress)
        }
        .padding([.bottom])
    }
}

struct OptionButtonView: View {
    var sfName: String
    var action: () -> Void
    var body: some View {
        Button(action: action) {
            Image(systemName: sfName)
                .resizable()
                .scaledToFit()
        }
        .padding([.leading, .trailing], 25)
    }
}


struct OptionBarView_Previews: PreviewProvider {
    static var previews: some View {
        OptionBarView(showing: .constant(nil))
    }
}
