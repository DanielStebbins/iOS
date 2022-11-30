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
        VStack {
            if bubble.displayImage {
                if let image = bubble.image {
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .scaledToFit()
                        .border(Color(bubble: bubble), width: 2)
                        .padding()
                }
                else {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .padding()
                }
            }
            
//            if bubble.displayNotes {
//                MultilineTextInput(title: "Notes", text: Binding($bubble.notes)!)
//            }
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
