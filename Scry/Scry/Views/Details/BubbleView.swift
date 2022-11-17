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
        // Long winded, but both "$bubble.notes" and "Binding(bubble.notes)!" fail.
        MultilineTextInput(title: "Notes", text: Binding(get: { bubble.notes! }, set: { n in bubble.notes = n }))
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TitleView(bubble: bubble)
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
