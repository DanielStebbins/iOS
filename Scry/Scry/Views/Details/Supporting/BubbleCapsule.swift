//
//  BubbleCapsule.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

struct BubbleCapsule: View {
    let text: String
    let color: Color
    var font: Font?
    var body: some View {
        Text(text)
            .font(font ?? .body)
            .padding([.leading, .trailing], 7)
            .padding([.top, .bottom], 5)
            .background {
                Capsule()
                    .fill(color)
            }
    }
}
