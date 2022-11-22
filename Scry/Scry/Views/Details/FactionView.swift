//
//  FactionView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct FactionView: View {
    @ObservedObject var faction: Faction
    @State var isEditing = false
    
    var body: some View {
        ScrollView {
            BubbleView(bubble: faction, isEditing: $isEditing)
            
            if faction.displayMembers {
                CapsuleRow<Character>(bubble: faction, title: "Members", bubbles: faction.members!, addFunction: faction.addToMembers)
            }
            if faction.displayLocations {
                CapsuleRow<Location>(bubble: faction, title: "Locations", bubbles: faction.locations!, addFunction: faction.addToLocations)
            }
            if faction.displayItems {
                CapsuleRow<Item>(bubble: faction, title: "Items", bubbles: faction.items!, addFunction: faction.addToItems)
            }
            if faction.displaySuperfactions {
                CapsuleRow<Faction>(bubble: faction, title: "Superfactions", bubbles: faction.superfactions!, addFunction: faction.addToSuperfactions)
            }
            if faction.displaySubfactions {
                CapsuleRow<Faction>(bubble: faction, title: "Subfactions", bubbles: faction.subfactions!, addFunction: faction.addToSubfactions)
            }
            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .sheet(isPresented: $isEditing) {
            FactionEditSheet(faction: faction)
                .presentationDetents([.fraction(0.6)])
        }
    }
}
