//
//  BubbleCapsule.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/22/22.
//

import SwiftUI

struct BubbleCapsule: View {
    @ObservedObject var bubble: Bubble

    var body: some View {
        Label(bubble.name!, systemImage: bubble.systemImageName!)
            .padding([.leading, .trailing], 7)
            .padding([.top, .bottom], 5)
            .background {
                Capsule()
                    .fill(Color(bubble: bubble))
            }
            .foregroundColor(Color(UIColor.label))
    }
}
