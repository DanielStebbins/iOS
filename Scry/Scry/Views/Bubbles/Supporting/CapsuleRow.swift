//
//  CapsuleRow.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

// T is the type of bubbles in the row, needed for linking to the correct detail sheet.
struct CapsuleRow<T>: View where T: Bubble {
    @ObservedObject var bubble: Bubble
    var bubbles: [T]
    
    var body: some View {
        HStack {
            ForEach(bubbles) { b in
                LinkedBubbleCapsule<T>(bubble: b)
            }
        }
    }
}
