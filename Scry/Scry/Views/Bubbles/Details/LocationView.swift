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
            GeometryReader { geometry in
                VStack {
                    CapsuleGrid<Faction>(bubble: location, title: "Factions", bubbles: location.factions!, addFunction: location.addToFactions, shown: location.displayFactions, maxWidth: geometry.size.width)
                    CapsuleGrid<Character>(bubble: location, title: "Characters", bubbles: location.characters!, addFunction: location.addToCharacters, shown: location.displayCharacters, maxWidth: geometry.size.width)
                    CapsuleGrid<Item>(bubble: location, title: "Items", bubbles: location.items!, addFunction: location.addToItems, shown: location.displayItems, maxWidth: geometry.size.width)
                }
            }
        }
        .sheet(isPresented: $isEditing) {
            LocationEditSheet(location: location, dismissParent: dismiss)
                .presentationDetents([.fraction(0.6)])
        }
        EmptyView()
    }
}
