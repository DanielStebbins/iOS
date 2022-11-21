//
//  BubbleView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/16/22.
//

import SwiftUI

struct BubbleView: View {
    @ObservedObject var bubble: Bubble
    @Binding var isEditing: Bool
    
    var body: some View {
        MultilineTextInput(title: "Notes", text: Binding($bubble.notes)!)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                TitleView(bubble: bubble, isEditing: $isEditing)
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
