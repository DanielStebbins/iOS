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
    var mappedBubbles: [MappedBubble] { map.mappedBubbles!.allObjects as! [MappedBubble] }
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            ZoomingScrollView {
                ZStack {
                    Color.blue
                    Image(uiImage: UIImage(imageLiteralResourceName: "square-grid"))
                        .resizable()
                        .scaledToFit()
                    ForEach(mappedBubbles) {mappedBubble in
                        BubbleCapsule(bubble: mappedBubble.bubble!)
                    }
                }
                
            }
        }
    }
}

