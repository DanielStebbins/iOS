//
//  FactionEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/21/22.
//

import SwiftUI

struct FactionEditSheet: View {
    @ObservedObject var faction: Faction
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button("Dismiss") {
                dismiss()
            }
        }
        
        NavigationStack() {
            VStack {
                BubbleEditSheet(bubble: faction)
                DisplayElementButton(text: "Members", display: $faction.displayMembers)
                DisplayElementButton(text: "Locations", display: $faction.displayLocations)
                DisplayElementButton(text: "Items", display: $faction.displayItems)
                DisplayElementButton(text: "Superfactions", display: $faction.displaySuperfactions)
                DisplayElementButton(text: "Subfactions", display: $faction.displaySubfactions)
                Spacer()
            }
            .padding()
            .toolbar { dismissButton }
        }
    }
}
