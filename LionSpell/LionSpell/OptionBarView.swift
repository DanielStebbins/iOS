//
//  OptionBarView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

// Displays the 3 option buttons: preferences, hint, and new game.
struct OptionBarView: View {
    var body: some View {
        HStack {
            PreferencesButtonView()
            HintButtonView()
            NewGameButtonView()
        }
        .padding([.bottom])
    }
}

// These three button views are similar, but the directions stressed separate views and each will have a unique action.
struct PreferencesButtonView: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "gearshape.fill")
                .resizable()
                .scaledToFit()
        }
        .padding([.leading, .trailing], 25)
    }
}

struct HintButtonView: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "questionmark.circle")
                .resizable()
                .scaledToFit()
        }
        .padding([.leading, .trailing], 25)
    }
}

struct NewGameButtonView: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "plus.circle")
                .resizable()
                .scaledToFit()
        }
        .padding([.leading, .trailing], 25)
    }
}


struct OptionBarView_Previews: PreviewProvider {
    static var previews: some View {
        OptionBarView()
    }
}
