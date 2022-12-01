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
    @State var tool: Tool = .addBubble
    @State var showSheet: Bool = false
    @State var x: Double = 0.0
    @State var y: Double = 0.0
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let addBubble = SpatialTapGesture()
            .onEnded { value in
                if showMapMenu {
                    withAnimation { showMapMenu = false }
                }
                else if tool == .addBubble {
                    showSheet = true
                    x = value.location.x
                    y = value.location.y
                }
            }
        
        ZoomingScrollView {
            MapView(map: map)
        }
        .gesture(addBubble)
        .navigationTitle(map.name!)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSheet) {
            AddBubbleSheet(map: map, x: x, y: y)
        }
    }
}

enum Tool: String, Identifiable {
    case pan, move, addBubble
    var id: RawValue { rawValue }
}
