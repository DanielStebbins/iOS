//
//  CharacterEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/20/22.
//

import SwiftUI

struct CharacterEditSheet: View {
    @ObservedObject var character: Character
    let dismissParent: DismissAction
    
    var body: some View {
        BubbleEditSheet(bubble: character, dismissParent: dismissParent) {
            VStack {
                DisplayElementButton(text: "Factions", display: $character.displayFactions)
                DisplayElementButton(text: "Locations", display: $character.displayLocations)
                DisplayElementButton(text: "Items", display: $character.displayItems)
            }
            .navigationTitle("Edit Character")
        }
    }
}

