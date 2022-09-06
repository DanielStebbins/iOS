//
//  GameManager.swift
//  LionSpell
//
//  Created by Thomas Stebbins on 9/5/22.
//

import Foundation

class GameManager : ObservableObject {
    @Published var scramble = Scramble()
    
    @Published var score: Int = 0
    
    // The Words struct uses lowercase, but I like the way uppercase looks in the GUI, so I have the upper case as a computed property.
    @Published var currentWordLower = ""
    var currentWordUpper: String {
        currentWordLower.uppercased()
    }
    
    @Published var guessedWords: Array<String> = []
    
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
        scramble = Scramble()
        score = 0
        currentWordLower = ""
        guessedWords = []
    }
    
    func updateScore() {
        if(currentWordLower.count == 4) {
            score += 1
        }
        else {
            score += currentWordLower.count
        }
        var usesAll: Bool = true
        for char in scramble.letters {
            if(!currentWordLower.contains(char)) {
                usesAll = false
            }
        }
        if(usesAll) {
            score += scramble.numLetters
        }
    }
}
