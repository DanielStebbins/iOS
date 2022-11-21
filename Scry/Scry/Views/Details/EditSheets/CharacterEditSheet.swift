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
        
        NavigationStack() {
            VStack {
                BubbleEditSheet(bubble: character)
                DisplayRowButton(text: "Factions", display: $character.displayFactions)
                DisplayRowButton(text: "Locations", display: $character.displayLocations)
                Spacer()
            }
            .padding()
            .toolbar { dismissButton }
        }
    }
}

