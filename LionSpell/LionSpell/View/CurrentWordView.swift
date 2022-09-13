//
//  CurrentWordView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

// Displays the current string of letters the user typed.
struct CurrentWordView: View {
    let word: String
    let highlighted: String
    var body: some View {
        HStack {
            ForEach(Array(word.enumerated()), id: \.offset) { letter in
                Text(String(letter.element))
                    .padding([.leading, .trailing], 3)
                    .foregroundColor(String(letter.element).lowercased() == highlighted ? .yellow : .white)
            }
        }
        .font(.largeTitle)
        .foregroundColor(.white)
        .padding(.bottom, 50)
    }
}


struct CurrentWordView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWordView(word: "PEPPY", highlighted: "P")
    }
}
