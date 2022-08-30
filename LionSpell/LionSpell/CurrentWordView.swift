//
//  CurrentWordView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct CurrentWordView: View {
    let word: String
    var body: some View {
        HStack {
            ForEach(Array(word), id: \.self) { char in
                SingleLetterView(letter: String(char))
            }
        }
    }
}

struct CurrentWordView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWordView(word: "PEPPY")
    }
}

struct SingleLetterView: View {
    let letter: String
    var body: some View {
        Text(letter)
            .font(.largeTitle)
            .padding(10)
            .foregroundColor(.white)
    }
}
