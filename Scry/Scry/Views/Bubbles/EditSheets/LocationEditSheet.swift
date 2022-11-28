//
//  LocationEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/21/22.
//

import SwiftUI

struct LocationEditSheet: View {
    @ObservedObject var location: Location
    var dismissDetailView: DismissAction
    @Environment (\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        NavigationStack {
            VStack {
                BubbleEditSheet(bubble: location)
                DisplayElementButton(text: "Factions", display: $location.displayFactions)
                DisplayElementButton(text: "Characters", display: $location.displayCharacters)
                DisplayElementButton(text: "Items", display: $location.displayItems)
                Spacer()
            }
            .padding()
            .toolbar { DismissButton(dismiss: dismiss).toolbarItem }
            .toolbar { DeleteButton(dismiss: dismiss, dismissParent: dismissDetailView, deleteAction: { context.delete(location) }).toolbarItem }
        }
    }
}
