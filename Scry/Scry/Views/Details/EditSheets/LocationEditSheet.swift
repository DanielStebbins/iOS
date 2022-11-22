//
//  LocationEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/21/22.
//

import SwiftUI

struct LocationEditSheet: View {
    @ObservedObject var location: Location
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button("Dismiss") {
                dismiss()
            }
        }
        
        NavigationStack() {
            VStack {
                BubbleEditSheet(bubble: location)
                DisplayElementButton(text: "Factions", display: $location.displayFactions)
                DisplayElementButton(text: "Characters", display: $location.displayCharacters)
                DisplayElementButton(text: "Items", display: $location.displayItems)
                Spacer()
            }
            .padding()
            .toolbar { dismissButton }
        }
    }
}
