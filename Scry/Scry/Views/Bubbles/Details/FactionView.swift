//
//  FactionView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct FactionView: View {
    @ObservedObject var faction: Faction
    @Environment (\.dismiss) private var dismiss
    @State var isEditing: Bool = false
    
    var body: some View {
        BubbleView(bubble: faction, isEditing: $isEditing) {
            VStack {
                CapsuleRow<Character>(bubble: faction, title: "Members", bubbles: faction.members!, addFunction: faction.addToMembers)
                CapsuleRow<Location>(bubble: faction, title: "Locations", bubbles: faction.locations!, addFunction: faction.addToLocations)
                CapsuleRow<Item>(bubble: faction, title: "Items", bubbles: faction.items!, addFunction: faction.addToItems)
                CapsuleRow<Faction>(bubble: faction, title: "Superfactions", bubbles: faction.superfactions!, addFunction: faction.addToSuperfactions)
                CapsuleRow<Faction>(bubble: faction, title: "Subfactions", bubbles: faction.subfactions!, addFunction: faction.addToSubfactions)
            }
        }
        .sheet(isPresented: $isEditing) {
            FactionEditSheet(faction: faction, dismissParent: dismiss)
                .presentationDetents([.fraction(0.7)])
        }
    }
}
