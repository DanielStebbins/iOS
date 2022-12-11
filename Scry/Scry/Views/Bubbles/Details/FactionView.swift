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
            GeometryReader { geometry in
                VStack {
                    CapsuleGrid<Character>(bubble: faction, title: "Members", bubbles: faction.members!, addFunction: faction.addToMembers, shown: faction.displayMembers, maxWidth: geometry.size.width)
                    CapsuleGrid<Location>(bubble: faction, title: "Locations", bubbles: faction.locations!, addFunction: faction.addToLocations, shown: faction.displayLocations, maxWidth: geometry.size.width)
                    CapsuleGrid<Item>(bubble: faction, title: "Items", bubbles: faction.items!, addFunction: faction.addToItems, shown: faction.displayItems, maxWidth: geometry.size.width)
                    CapsuleGrid<Faction>(bubble: faction, title: "Superfactions", bubbles: faction.superfactions!, addFunction: faction.addToSuperfactions, shown: faction.displaySuperfactions, maxWidth: geometry.size.width)
                    CapsuleGrid<Faction>(bubble: faction, title: "Subfactions", bubbles: faction.subfactions!, addFunction: faction.addToSubfactions, shown: faction.displaySubfactions, maxWidth: geometry.size.width)
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            FactionEditSheet(faction: faction, dismissParent: dismiss)
                .presentationDetents([.fraction(0.7)])
        }
        EmptyView()
    }
}
