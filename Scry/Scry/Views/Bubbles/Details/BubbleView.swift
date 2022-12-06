//
//  BubbleView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/16/22.
//

import SwiftUI

struct BubbleView<Content>: View where Content: View {
    @ObservedObject var bubble: Bubble
    @Binding var isEditing: Bool
    let content: () -> Content
    
    var body: some View {
        ScrollView {
            if let image = bubble.image {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .scaledToFit()
                    .border(Color(bubble: bubble), width: 2)
                    .padding()
            }
            
            MultilineTextInput(title: "Notes", text: Binding($bubble.notes)!)
            
            content()
            Spacer()
        }
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
