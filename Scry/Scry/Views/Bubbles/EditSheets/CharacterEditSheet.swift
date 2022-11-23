//
//  CharacterEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/20/22.
//

import SwiftUI

struct CharacterEditSheet: View {
    @ObservedObject var character: Character
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
            Button(role: .destructive, action: { dismiss(); context.delete(character); dismissDetailView() }) {
                Image(systemName: "trash")
            }
        }
        
        NavigationStack() {
            VStack {
                BubbleEditSheet(bubble: character)
                DisplayElementButton(text: "Factions", display: $character.displayFactions)
                DisplayElementButton(text: "Locations", display: $character.displayLocations)
                DisplayElementButton(text: "Items", display: $character.displayItems)
                Spacer()
            }
            .padding()
            .toolbar { dismissButton }
            .toolbar { deleteButton }
        }
    }
}

