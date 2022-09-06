//
//  ContentView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct LionSpellView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        ZStack {
            // Background Color
            Color("PSUBlue")
                .ignoresSafeArea()
            
            // Holds all sub-views.
            VStack {
                ScoreDisplayView(score: gameManager.score)
                WordListView(words: gameManager.guessedWords)
                Spacer()
                CurrentWordView(word: gameManager.currentWordUpper)
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
