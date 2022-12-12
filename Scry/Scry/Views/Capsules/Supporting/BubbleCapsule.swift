//
//  BubbleCapsule.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/22/22.
//

import SwiftUI

// The main capsule view for all bubbles.
struct BubbleCapsule: View {
    @ObservedObject var bubble: Bubble
    var size: Double = Constants.capsuleSize
    
    var body: some View {
        HStack {
            if let image = bubble.image {
                Image(uiImage: UIImage(data: image)!)
                    .resizable()
                    .scaledToFill()
                    .frame(width: size, height: size)
                    .clipped()
                    .cornerRadius(size / 2)
            }
            else {
                Image(systemName: bubble.systemImageName!)
            }
            Text(bubble.name!)
                .padding(.leading, Constants.capsuleCenterPadding + size * Constants.capsuleCenterPaddingFraction)
        }
        .padding([.leading, .trailing], size * Constants.capsuleVerticalPaddingFraction)
        .padding([.top, .bottom], size * Constants.capsuleHorizontalPaddingFraction)
        .background {
            Capsule()
                .fill(Color(bubble: bubble))
        }
        .foregroundColor(Color(UIColor.label))
    }
}
