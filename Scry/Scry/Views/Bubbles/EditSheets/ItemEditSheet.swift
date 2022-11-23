//
//  ItemEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/21/22.
//

import SwiftUI

struct ItemEditSheet: View {
    @ObservedObject var item: Item
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
            Button(role: .destructive, action: { dismiss(); context.delete(item);  dismissDetailView() }) {
                Image(systemName: "trash")
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
            .toolbar { deleteButton }
        }
    }
}
