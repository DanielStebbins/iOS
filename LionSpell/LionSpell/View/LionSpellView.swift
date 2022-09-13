//
//  ContentView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

enum Showing : String, Identifiable, CaseIterable {
    case preferences, hints
    var id: RawValue { rawValue }
}

struct LionSpellView: View {
    @EnvironmentObject var gameManager: GameManager
    @State private var showing: Showing?
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
                CurrentWordView(word: gameManager.currentWordUpper, highlighted: String(gameManager.scramble.letters.first!))
                KeyBoardView(options: gameManager.scramble.letters)
                SubmitButtonView()
                OptionBarView(showing: $showing)
            }
        }
        .sheet(item: $showing) { item in
            switch item {
            case .preferences: PreferencesView(preferences: $gameManager.preferences)
            case .hints: HintsView()
            }
        }
    }
}

struct LionSpellView_Preview: PreviewProvider {
    static var previews: some View {
        LionSpellView()
            .environmentObject(GameManager())
    }
}
