//
//  GameManager.swift
//  LionSpell
//
//  Created by Thomas Stebbins on 9/5/22.
//

import Foundation

let numLetters: Int = 5
let lowScoreCutoffLength: Int = 4

class GameManager : ObservableObject {
    // The new game button changes the Scramble, which requires the letter buttons to be redrawn.
    @Published var scramble = Scramble(letterCount: numLetters)
    @Published var score: Int = 0
    @Published var currentWordLower = ""
    @Published var guessedWords: Array<String> = []
    
    // The Words struct uses lowercase, but I like the way uppercase looks in the GUI, so I have the upper case as a computed property.
    var currentWordUpper: String {
        currentWordLower.uppercased()
    }
    
    var deleteButtonDisabled: Bool {
        currentWordLower.isEmpty
    }
    
    var submitButtonDisabled: Bool {
        !Words.words.contains(currentWordLower) || guessedWords.contains(currentWordUpper)
    }
    
    // Returns the function letter buttons should call, since each button action uses a different letter.
    func letterButtonPress(letter: String) -> () -> Void{
        {
            self.currentWordLower.append(letter.lowercased())
        }
    }
    
    func deleteButtonPress() {
        currentWordLower.removeLast()
    }
    
    func submitButtonPress() {
        guessedWords.append(currentWordUpper)
        updateScore()
        currentWordLower = ""
    }
    
    func newGameButtonPress() {
        scramble = Scramble(letterCount: numLetters)
        score = 0
        currentWordLower = ""
        guessedWords = []
    }
    
    private func updateScore() {
        if(currentWordLower.count <= lowScoreCutoffLength) {
            score += 1
        }
        else {
            score += currentWordLower.count
        }
        if(Set(currentWordLower) == Set(scramble.letters)) {
            score += scramble.numLetters
        }
    }
}
