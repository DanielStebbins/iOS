//
//  FactionView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct FactionView: View {
    var faction: Faction
    @State var isEditing = false
    
    var body: some View {
        ScrollView {
            BubbleView(bubble: faction, isEditing: $isEditing)
            CapsuleRow<Location>(bubble: faction, title: "Locations", bubbles: faction.locations!, addFunction: faction.addToLocations)
            CapsuleRow<Faction>(bubble: faction, title: "Superfactions", bubbles: faction.superfactions!, addFunction: faction.addToSuperfactions)
            CapsuleRow<Faction>(bubble: faction, title: "Subfactions", bubbles: faction.subfactions!, addFunction: faction.addToSubfactions)
            CapsuleRow<Character>(bubble: faction, title: "Members", bubbles: faction.members!, addFunction: faction.addToMembers)
            CapsuleRow<Item>(bubble: faction, title: "Items", bubbles: faction.items!, addFunction: faction.addToItems)
            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
