//
//  WordListView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct WordListView: View {
    let words: Array<String>
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(words, id: \.self) { word in
                    SingleWordView(word: word)
                }
            }
            .padding()
        }
    }
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView(words: ["PEST", "TYPES"])
    }
}

struct SingleWordView: View {
    let word: String
    var body: some View {
        Text(word)
    }
}
