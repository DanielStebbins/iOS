//
//  ContentView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct LionSpellView: View {
    var body: some View {
        VStack {
            WordListView()
            CurrentWordView(word: "PEPPY")
            LetterButtonsView(options: "TPESY")
            DeleteButtonView()
            SubmitButtonView()
            ScoreDisplayView()
            NewGameButtonView()
            HintButtonView()
            PreferencesButtonView()
        }
    }
}

struct LionSpellView_Preview: PreviewProvider {
    static var previews: some View {
        LionSpellView()
    }
}
