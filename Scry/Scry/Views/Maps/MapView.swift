//
//  MapView.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/23/22.
//

import SwiftUI
import PDFKit

struct MapView: View {
    @Environment(\.managedObjectContext) var context
    @ObservedObject var map: Map
    var mappedBubbles: [MappedBubble] { map.mappedBubbles!.allObjects as! [MappedBubble] }
    
    var body: some View {
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
        
        ZStack(alignment: .topLeading) {
            ZoomingScrollView {
                ZStack(alignment: .topLeading) {
                    Image(uiImage: UIImage(imageLiteralResourceName: "square-grid"))
                        .resizable()
                        .scaledToFit()
                        .gesture(addBubble)
                    ForEach(mappedBubbles) {mappedBubble in
                        BubbleCapsule(bubble: mappedBubble.bubble!)
                            .offset(CGSize(width: mappedBubble.x, height: mappedBubble.y))
                    }
                }
            }
        }
    }
}

