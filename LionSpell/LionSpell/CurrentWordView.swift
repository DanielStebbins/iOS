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
    var body: some View {
        HStack {
            ForEach(Array(word), id: \.self) { letter in
                Text(String(letter))
                    .padding(10)
            }
        }
        .font(.largeTitle)
        .foregroundColor(.white)
    }
}


struct CurrentWordView_Previews: PreviewProvider {
    static var previews: some View {
        CurrentWordView(word: "PEPPY")
    }
}
