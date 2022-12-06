//
//  LocationView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct LocationView: View {
    @ObservedObject var location: Location
    @Environment (\.dismiss) private var dismiss
    @State var isEditing: Bool = false
    
    var body: some View {
        BubbleView(bubble: location, isEditing: $isEditing) {
            VStack {
                if location.factions!.count != 0 {
                    CapsuleRow<Faction>(bubble: location, title: "Factions", bubbles: location.factions!, addFunction: location.addToFactions)
                }
                if location.characters!.count != 0 {
                    CapsuleRow<Character>(bubble: location, title: "Characters", bubbles: location.characters!, addFunction: location.addToCharacters)
                }
                if location.items!.count != 0 {
                    CapsuleRow<Item>(bubble: location, title: "Items", bubbles: location.items!, addFunction: location.addToItems)
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            LocationEditSheet(location: location, dismissParent: dismiss)
                .presentationDetents([.fraction(0.6)])
        }
    }
}
