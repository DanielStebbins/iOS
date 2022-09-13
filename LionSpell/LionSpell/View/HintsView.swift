//
//  HintsView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 9/12/22.
//

import SwiftUI

struct HintsView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        Form {
            Section(header: Text("Summary")) {
                Text("Total Number of Words: \(gameManager.scramble.words.count)")
                Text("Total Possible Points: \(gameManager.possibleScore())")
                Text("Total Number of Pangrams: \(gameManager.numberOfPangrams())")
            }
            
            ForEach(gameManager.wordLengths(), id: \.self) { length in
                Section(header: Text("Words of Length \(length) That Begin With:")) {
                    ForEach(gameManager.firstLetterFrequencies(length: length).sorted(by: >), id: \.key) { key, value in
                        Text("'\(key)': \(value)")
                    }
                }
            }
        }
    }
}

struct HintsView_Previews: PreviewProvider {
    static var previews: some View {
        HintsView()
    }
}
