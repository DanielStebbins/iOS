//
//  KeyBoardView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

// Displays the letter buttons and the delete button.
struct KeyBoardView: View {
    let options: String
    var body: some View {
        HStack {
            ForEach(Array(options), id: \.self) { char in
                LetterButtonView(letter: String(char))
            }
            DeleteButtonView()
        }
    }
}

// Displays a button for typing a single letter.
struct LetterButtonView: View {
    let letter: String
    var body: some View {
        Button(action: {}) {
            Text(String(letter))
                .font(.title)
                .foregroundColor(.white)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2))
        }
    }
}

// Displays the delete button, for removing one letter.
struct DeleteButtonView: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "delete.left")
                .foregroundColor(.red)
                .padding([.top, .bottom])
                .padding([.leading, .trailing], 8)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2))
        }
    }
}


struct LetterButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        KeyBoardView(options: "TPESY")
    }
}
