//
//  CapsuleRow.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

struct CapsuleRow: View {
    let title: String
    let bubbles: [Bubble]
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(bubbles) { bubble in
                        BubbleCapsule(text: bubble.name!, color: Color(bubble: bubble))
                    }
                }
            }
        }
        .padding()
    }
}
