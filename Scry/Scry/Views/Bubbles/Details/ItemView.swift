//
//  ItemView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct ItemView: View {
    @ObservedObject var item: Item
    @Environment (\.dismiss) private var dismiss
    @State var isEditing = false
    
    var body: some View {
        BubbleView(bubble: item, isEditing: $isEditing) {
            VStack {
                CapsuleRow<Location>(bubble: item, title: "Locations", bubbles: item.locations!, addFunction: item.addToLocations)
                CapsuleRow<Character>(bubble: item, title: "Held By Characters", bubbles: item.characters!, addFunction: item.addToCharacters)
                CapsuleRow<Faction>(bubble: item, title: "Held By Factions", bubbles: item.factions!, addFunction: item.addToFactions)
            }
        }
        .sheet(isPresented: $isEditing) {
            ItemEditSheet(item: item, dismissParent: dismiss)
                .presentationDetents([.fraction(0.6)])
        }
    }
}
    
