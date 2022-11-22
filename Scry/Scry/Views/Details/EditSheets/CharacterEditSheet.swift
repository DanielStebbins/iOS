//
//  CharacterEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/20/22.
//

import SwiftUI

struct CharacterEditSheet: View {
    @ObservedObject var character: Character
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button("Dismiss") {
                dismiss()
            }
        }
        
//        Button(role: .destructive, action: {
//            context.delete(bubble)
//            dismiss()
//        },
//               label: {Image(systemName: "trash").imageScale(.large)})
        
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
        }
    }
}

