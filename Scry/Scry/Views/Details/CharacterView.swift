//
//  CharacterView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct CharacterView: View {
    @ObservedObject var character: Character
    @State var isEditing = false
    
    var body: some View {
        ScrollView {
            BubbleView(bubble: character, isEditing: $isEditing)
            if character.displayFactions {
                CapsuleRow<Faction>(bubble: character, title: "Factions", bubbles: character.factions!, addFunction: character.addToFactions)
            }
            if character.displayLocations {
                CapsuleRow<Location>(bubble: character, title: "Locations", bubbles: character.locations!, addFunction: character.addToLocations)
            }
            if character.displayItems {
                CapsuleRow<Item>(bubble: character, title: "Items", bubbles: character.items!, addFunction: character.addToItems)
            }
            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .sheet(isPresented: $isEditing) {
            CharacterEditSheet(character: character)
                .presentationDetents([.fraction(0.6)])
        }
    }
}
