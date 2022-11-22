//
//  ItemEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/21/22.
//

import SwiftUI

struct ItemEditSheet: View {
    @ObservedObject var item: Item
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button("Dismiss") {
                dismiss()
            }
        }
        
        NavigationStack() {
            VStack {
                BubbleEditSheet(bubble: item)
                DisplayElementButton(text: "Locations", display: $item.displayLocations)
                DisplayElementButton(text: "Held By Characters", display: $item.displayCharacters)
                DisplayElementButton(text: "Held By Factions", display: $item.displayFactions)
                Spacer()
            }
            .padding()
            .toolbar { dismissButton }
        }
    }
}
