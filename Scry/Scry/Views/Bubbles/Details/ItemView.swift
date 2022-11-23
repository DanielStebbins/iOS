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
        ScrollView {
            BubbleView(bubble: item, isEditing: $isEditing)
            if item.displayLocations {
                CapsuleRow<Location>(bubble: item, title: "Locations", bubbles: item.locations!, addFunction: item.addToLocations)
            }
            if item.displayCharacters {
                CapsuleRow<Character>(bubble: item, title: "Held By Characters", bubbles: item.characters!, addFunction: item.addToCharacters)
            }
            if item.displayFactions {
                CapsuleRow<Faction>(bubble: item, title: "Held By Factions", bubbles: item.factions!, addFunction: item.addToFactions)
            }
            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .sheet(isPresented: $isEditing) {
            ItemEditSheet(item: item, dismissDetailView: dismiss)
                .presentationDetents([.fraction(0.6)])
        }
    }
}

