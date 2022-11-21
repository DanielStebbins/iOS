//
//  LocationView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct LocationView: View {
    var location: Location
    @State var isEditing = false
    
    var body: some View {
        ScrollView {
            BubbleView(bubble: location, isEditing: $isEditing)
            CapsuleRow<Faction>(bubble: location, title: "Factions", bubbles: location.factions!, addFunction: location.addToFactions)
            CapsuleRow<Character>(bubble: location, title: "Characters", bubbles: location.characters!, addFunction: location.addToCharacters)
            CapsuleRow<Item>(bubble: location, title: "Items", bubbles: location.items!, addFunction: location.addToItems)
            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
