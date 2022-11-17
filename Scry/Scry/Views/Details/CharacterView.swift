//
//  CharacterView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct CharacterView: View {
    var character: Character
    var body: some View {
        ScrollView {
            BubbleView(bubble: character)
            CapsuleRow<Location>(bubble: character, title: "Locations", bubbles: character.locations!, addFunction: character.addToLocations)
            CapsuleRow<Faction>(bubble: character, title: "Factions", bubbles: character.factions!, addFunction: character.addToFactions)
            CapsuleRow<Item>(bubble: character, title: "Items", bubbles: character.items!, addFunction: character.addToItems)
            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
