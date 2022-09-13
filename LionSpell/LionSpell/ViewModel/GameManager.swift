//
//  GameManager.swift
//  LionSpell
//
//  Created by Thomas Stebbins on 9/5/22.
//

import Foundation

let lowScoreCutoffLength: Int = 4

class GameManager : ObservableObject {
    // Initializes the first Scramble with default preferences because the preferences variable cannot be referenced before initialization.
    @Published var scramble = Scramble(preferences: Preferences())
    @Published var score: Int = 0
    @Published var currentWordLower: String = ""
    @Published var guessedWords: Array<String> = []
    
    @Published var preferences = Preferences() {
        didSet {
            newGame()
        }
    }
    
    // The Words struct uses lowercase, but I like the way uppercase looks in the GUI, so I have the upper case as a computed property.
    var currentWordUpper: String {
        currentWordLower.uppercased()
    }
    
    var deleteButtonDisabled: Bool {
        currentWordLower.isEmpty
    }
    
    var submitButtonDisabled: Bool {
        !scramble.words.contains(currentWordLower) || guessedWords.contains(currentWordUpper)
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
        score += scoreWord(word: currentWordLower)
        currentWordLower = ""
    }
    
    func newGameButtonPress() {
        newGame()
    }
    
    func newGame() {
        scramble = Scramble(preferences: preferences)
        score = 0
        currentWordLower = ""
        guessedWords = []
    }
    
    func scoreWord(word: String) -> Int {
        var score: Int = 0
        if(word.count <= lowScoreCutoffLength) {
            score += 1
        }
        else {
            score += word.count
        }
        if(Set(word) == Set(scramble.letters)) {
            score += preferences.difficulty.rawValue
        }
        return score
    }
    
    // Functions for HintsView
    func possibleScore() -> Int {
        var score: Int = 0
        for word in scramble.words {
            score += scoreWord(word: word)
        }
        return score
    }
    
    func numberOfPangrams() -> Int {
        scramble.words.reduce(0, { count, word in count + (Set(word) == Set(scramble.letters) ? 1 : 0)})
    }
    
    // Returns an array of all word lengths present in any answer.
    func wordLengths() -> Array<Int> {
        scramble.words.map({ $0.count }).unique().sorted()
    }
    
    // Returns a dictionary mapping a letter to the number of words of length "length" that start with that letter.
    func firstLetterFrequencies(length: Int) -> [String: Int] {
        let words = scramble.words.filter({ $0.count == length })
        var dict = [String: Int]()
        for word in words {
            if dict[word.first!.uppercased()] == nil {
                dict[word.first!.uppercased()] = 1
            }
            else {
                dict[word.first!.uppercased()]! += 1
            }
        }
        return dict
    }
}

extension Array where Element: Hashable {
    func unique() -> Array<Element> {
        var set: Set<Element> = []
        return filter{ set.insert($0).inserted }
    }
}
