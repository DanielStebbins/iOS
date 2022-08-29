//
//  LetterButtonsView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct LetterButtonsView: View {
    let options: String
    var body: some View {
        HStack {
            ForEach(Array(options), id: \.self) { char in
                LetterButtonView(letter: String(char))
            }
        }
    }
}

struct LetterButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        LetterButtonsView(options: "TPESY")
    }
}

struct LetterButtonView: View {
    let letter: String
    var body: some View {
        Button(letter, action: {})
            .padding()
    }
}
