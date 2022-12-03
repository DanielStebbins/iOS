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
    @State var tool: Tool = .select
    @State var showSheet: Bool = false
    @State var x: Double = 0.0
    @State var y: Double = 0.0
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let toolbar = ToolbarItemGroup(placement: .bottomBar) {
            Spacer()
            Picker("Tool", selection: $tool) {
                ForEach(Tool.allCases) {
                    Label($0.rawValue, systemImage: $0.imageName).tag($0).imageScale(.large)
                }
            }
            .pickerStyle(.menu)
            .disabled(showMapMenu)
            Spacer()
        }
        
        let tap = SpatialTapGesture()
            .onEnded { value in
                if showMapMenu {
                    withAnimation { showMapMenu = false }
                }
                else if tool == .newBubble {
                    showSheet = true
                    x = value.location.x
                    y = value.location.y
                }
                else if tool == .linkBubble {
                    
                }
            }
        
        ZoomingScrollView {
            MapView(map: map)
        }
        .gesture(tap)
        .navigationTitle(map.name!)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSheet) {
            AddBubbleSheet(map: map, x: $x, y: $y)
                .presentationDetents([.fraction(0.3)])
        }
        .toolbar { toolbar }
    }
}

enum Tool: String, Identifiable, CaseIterable {
    case select = "Select", newBubble = "New Bubble", linkBubble = "Existing Bubble"
    var id: RawValue { rawValue }
    var imageName: String {
        switch self {
        case .select: return "cursorarrow"
        case .newBubble: return "plus"
        case .linkBubble: return "link"
        }
    }
}
