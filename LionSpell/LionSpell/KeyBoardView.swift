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
        Button(action: {}) {
            Text(String(letter))
                .font(.title)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2))
        }
    }
}

struct DeleteButtonView: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "delete.left")
                .padding([.top, .bottom])
                .padding([.leading, .trailing], 8)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.black, lineWidth: 2))
        }
    }
}
