//
//  KeyBoardView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct KeyBoardView: View {
    let options: String
    var body: some View {
        HStack {
            ForEach(Array(options), id: \.self) { char in
                LetterButtonView(letter: String(char))
            }
            DeleteButtonView()
                .padding()
        }
    }
}

struct LetterButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        KeyBoardView(options: "TPESY")
    }
}

struct LetterButtonView: View {
    let letter: String
    var body: some View {
        Button(letter, action: {})
            .font(.title)
            .padding(10)
    }
}

struct DeleteButtonView: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "delete.left")
        }
    }
}
