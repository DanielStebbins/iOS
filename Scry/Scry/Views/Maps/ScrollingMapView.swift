//
//  ScrollingMapView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/30/22.
//

import SwiftUI

struct ScrollingMapView: View {
    @ObservedObject var map: Map
    @Binding var showMapMenu: Bool
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let addBubble = SpatialTapGesture()
            .onEnded { value in
                if !showMapMenu {
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
                else {
                    withAnimation { showMapMenu = false }
                }
            }
        
        ZoomingScrollView {
            MapView(map: map)
        }
        .gesture(addBubble)
        .navigationTitle(map.name!)
        .navigationBarTitleDisplayMode(.inline)
    }
}
