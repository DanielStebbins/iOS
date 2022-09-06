//
//  GameModel.swift
//  LionSpell
//
//  Created by Thomas Stebbins on 9/5/22.
//

import Foundation

struct Scramble {
    let numLetters = 5
    let letters: String
    init() {
        var word: String = Words.words.randomElement()!
        while(word.count != numLetters) {
            word = Words.words.randomElement()!
        }
        var tempLetters: String = ""
        for _ in 0..<numLetters {
            // If the random 5-letter word has been exhausted (it might have had repeat letters).
            if(word.isEmpty) {
                word = Words.words.randomElement()!
            }
            var letter: Character = word.randomElement()!
            word = word.filter({ $0 != letter })
            while(tempLetters.contains(letter)) {
                if(word.isEmpty) {
                    word = Words.words.randomElement()!
                }
                letter = word.randomElement()!
                word = word.filter({ $0 != letter })
            }
            tempLetters.append(letter)
        }
        letters = tempLetters
        print(letters)
    }
}

struct Words {

    static let words = ["tests", "test", "diversity"]
}
