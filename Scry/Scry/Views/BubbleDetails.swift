//
//  BubbleDetails.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

struct BubbleDetails: View {
    @Binding var bubble: Bubble
    var body: some View {
        ScrollView {
            BubbleCapsule(text: bubble.title, color: bubble.color, font: .title)
            
            if(bubble.description != nil) {
                MultilineTextInput(title: "Description", text: Binding($bubble.description)!)
            }
            if(bubble.notes != nil) {
                MultilineTextInput(title: "Notes", text: Binding($bubble.notes)!)
            }
            if(bubble.memberOf != nil) {
                CapsuleRow(title: "Member Of", bubbles: bubble.memberOf!)
            }
            if(bubble.members != nil) {
                CapsuleRow(title: "Members", bubbles: bubble.members!)
            }
            if(bubble.allies != nil) {
                CapsuleRow(title: "Allies", bubbles: bubble.allies!)
            }
            if(bubble.enemies != nil) {
                CapsuleRow(title: "Enemies", bubbles: bubble.enemies!)
            }
        }
        .onTapGesture {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
    }
}
