//
//  WordListView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

// Displays the list of correctly guessed words horizontally.
struct WordListView: View {
    let words: Array<String>
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(words, id: \.self) { word in
                    SingleWordView(word: word)
                }
            }
            .foregroundColor(.white)
            .padding([.leading, .trailing], 10)
            .padding([.top, .bottom], 4)
        }
    }
}

// Displays a single guessed word inside a fancy border.
struct SingleWordView: View {
    let word: String
    var body: some View {
        Text(word)
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(.white, lineWidth: 2))
    }
}


struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView(words: ["PEST", "TYPES"])
    }
}
