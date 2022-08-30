//
//  ContentView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct LionSpellView: View {
    var body: some View {
        ZStack {
            Color("PSUBlue")
                .ignoresSafeArea()
            VStack {
                ScoreDisplayView(score: 13)
                WordListView(words: ["PEST", "TYPES"])
                Spacer()
                CurrentWordView(word: "PEPPY")
                KeyBoardView(options: "TPESY")
                SubmitButtonView()
                OptionBarView()
            }
        }
    }
}

struct LionSpellView_Preview: PreviewProvider {
    static var previews: some View {
        LionSpellView()
    }
}
