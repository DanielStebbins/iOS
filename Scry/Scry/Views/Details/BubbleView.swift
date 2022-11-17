//
//  BubbleView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/16/22.
//

import SwiftUI

struct BubbleView: View {
    var bubble: Bubble
    var body: some View {
        VStack {
            TitleView(bubble: bubble)
            
            // Long winded, but both "$bubble.notes" and "Binding(bubble.notes)!" fail.
            MultilineTextInput(title: "Notes", text: Binding(get: { bubble.notes! }, set: { n in bubble.notes = n }))
            
            CapsuleRow<Item>(title: "Items", bubbles: bubble.items!, addFunction: bubble.addToItems)
            CapsuleRow<Location>(title: "Locations", bubbles: bubble.locations!, addFunction: bubble.addToLocations)
        }
    }
}
