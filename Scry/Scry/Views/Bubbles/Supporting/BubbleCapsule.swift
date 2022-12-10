//
//  BubbleCapsule.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/22/22.
//

import SwiftUI

struct BubbleCapsule: View {
    @ObservedObject var bubble: Bubble
    var size: Double = 20
    
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
                .padding(.leading, -8 + size / 15)
        }
        .padding([.leading, .trailing], size / 2)
        .padding([.top, .bottom], size / 4)
        .background {
            Capsule()
                .fill(Color(bubble: bubble))
        }
        .foregroundColor(Color(UIColor.label))
    }
}
