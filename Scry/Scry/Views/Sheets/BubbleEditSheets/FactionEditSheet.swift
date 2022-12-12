//
//  FactionEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/21/22.
//

import SwiftUI

struct FactionEditSheet: View {
    @ObservedObject var faction: Faction
    let dismissParent: DismissAction
    
    var body: some View {
        BubbleEditSheet(bubble: faction, dismissParent: dismissParent) {
            VStack {
                DisplayElementButton(text: "Members", display: $faction.displayMembers)
                DisplayElementButton(text: "Locations", display: $faction.displayLocations)
                DisplayElementButton(text: "Items", display: $faction.displayItems)
                DisplayElementButton(text: "Superfactions", display: $faction.displaySuperfactions)
                DisplayElementButton(text: "Subfactions", display: $faction.displaySubfactions)
            }
        }
    }
}
