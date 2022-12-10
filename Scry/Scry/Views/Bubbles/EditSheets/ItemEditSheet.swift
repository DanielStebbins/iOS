//
//  ItemEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/21/22.
//

import SwiftUI

struct ItemEditSheet: View {
    @ObservedObject var item: Item
    let dismissParent: DismissAction
    
    var body: some View {
        BubbleEditSheet(bubble: item, dismissParent: dismissParent) {
            VStack {
                DisplayElementButton(text: "Locations", display: $item.displayLocations)
                DisplayElementButton(text: "Held By Characters", display: $item.displayCharacters)
                DisplayElementButton(text: "Held By Factions", display: $item.displayFactions)
            }
            .navigationTitle("Edit Item")
        }
    }
}
