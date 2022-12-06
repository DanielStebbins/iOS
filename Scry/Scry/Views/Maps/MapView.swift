//
//  MapView.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/23/22.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var map: Map
    @Binding var selectedBubble: Bubble?
    let selecting: Bool
    @Binding var showConfirmation: Bool
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let uiImage = map.image == nil ? UIImage(imageLiteralResourceName: "square-grid") : UIImage(data: map.image!)!
        
        let bubbleSet: NSSet = map.mappedBubbles!
        let mappedBubbles: [MappedBubble] = bubbleSet.allObjects as! [MappedBubble]
        
        ZStack(alignment: .leading) {
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
            ForEach(mappedBubbles) {mappedBubble in
                BubbleCapsule(bubble: mappedBubble.bubble!)
                    .position(x: mappedBubble.x, y: mappedBubble.y)
                    .onTapGesture {
                        if selecting {
                            selectedBubble = mappedBubble.bubble!
                            showConfirmation = true
                        }
                    }
            }
        }
    }
}
