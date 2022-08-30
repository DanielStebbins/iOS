//
//  OptionBarView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct OptionBarView: View {
    var body: some View {
        HStack {
            PreferencesButtonView()
            HintButtonView()
            NewGameButtonView()
        }
        .padding([.bottom])
        .foregroundColor(Color(red: 17/255, green: 46/255, blue: 95/255))
    }
}

struct OptionBarView_Previews: PreviewProvider {
    static var previews: some View {
        OptionBarView()
    }
}

struct NewGameButtonView: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "plus.circle")
                .resizable()
                .scaledToFit()
        }
        .padding([.leading, .trailing], 20)
    }
}

struct HintButtonView: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "questionmark.circle")
                .resizable()
                .scaledToFit()
        }
        .padding([.leading, .trailing], 20)
    }
}

struct PreferencesButtonView: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "gearshape.fill")
                .resizable()
                .scaledToFit()
        }
        .padding([.leading, .trailing], 20)
    }
}
