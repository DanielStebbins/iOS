//
//  FactionEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/21/22.
//

import SwiftUI

struct FactionEditSheet: View {
    @ObservedObject var faction: Faction
    var dismissDetailView: DismissAction
    @Environment (\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button("Dismiss") {
                dismiss()
            }
        }
        
        let deleteButton = ToolbarItem(placement: .navigationBarLeading) {
            Button(role: .destructive, action: { dismiss(); context.delete(faction); dismissDetailView() }) {
                Image(systemName: "trash")
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
            .toolbar { deleteButton }
        }
    }
}
