//
//  LocationEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/21/22.
//

import SwiftUI

struct LocationEditSheet: View {
    @ObservedObject var location: Location
    let dismissParent: DismissAction
    
    var body: some View {
        BubbleEditSheet(bubble: location, dismissParent: dismissParent) {
            VStack {
                DisplayElementButton(text: "Factions", display: $location.displayFactions)
                DisplayElementButton(text: "Characters", display: $location.displayCharacters)
                DisplayElementButton(text: "Items", display: $location.displayItems)
            }
        }
    }
}
