//
//  ItemView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    @State var isEditing = false
    
    var body: some View {
        ScrollView {
            BubbleView(bubble: item, isEditing: $isEditing)
            CapsuleRow<Location>(bubble: item, title: "Locations", bubbles: item.locations!, addFunction: item.addToLocations)
            CapsuleRow<HoldsItems>(bubble: item, title: "Held By", bubbles: item.heldBy!, addFunction: item.addToHeldBy)
            Spacer()
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}

