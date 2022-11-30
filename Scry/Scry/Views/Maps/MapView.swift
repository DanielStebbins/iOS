//
//  MapView.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/23/22.
//

import SwiftUI
import PDFKit

struct MapView: View {
    @ObservedObject var map: Map
    var width: CGFloat
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let bubbleSet: NSSet = map.mappedBubbles ?? NSSet()
        let mappedBubbles: [MappedBubble] = bubbleSet.allObjects as! [MappedBubble]
        
        let addBubble = SpatialTapGesture()
            .onEnded { value in
                let bubble = Character(context: context)
                bubble.name = "Test"
                bubble.red = Color.randomDark
                bubble.green = Color.randomDark
                bubble.blue = Color.randomDark
                let mappedBubble = MappedBubble(context: context)
                mappedBubble.bubble = bubble
                mappedBubble.x = value.location.x
                mappedBubble.y = value.location.y
                map.addToMappedBubbles(mappedBubble)
            }
        
        let uiImage = map.image == nil ? UIImage(imageLiteralResourceName: "square-grid") : UIImage(data: map.image!)!
        
        ZoomingScrollView {
            ZStack(alignment: .leading) {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFit()
                ForEach(mappedBubbles) {mappedBubble in
                    BubbleCapsule(bubble: mappedBubble.bubble!)
                        .position(x: mappedBubble.x, y: mappedBubble.y)
                }
            }
        }
        .gesture(addBubble)
        .navigationTitle(map.name ?? "")
        .navigationBarTitleDisplayMode(.inline)
    }
}

