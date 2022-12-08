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
    @State var sheet: MapShownSheet?
    @State var x: Double = 0.0
    @State var y: Double = 0.0
    @State var selectedBubble: Bubble?
    @State var showConfirmation: Bool = false
    @State var addMappedBubble: Bool = false
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let bottomToolbar = ToolbarItemGroup(placement: .bottomBar) {
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
                    sheet = .addBubble
                    x = value.location.x
                    y = value.location.y
                }
                else if tool == .linkBubble {
                    sheet = .bubbleList
                    x = value.location.x
                    y = value.location.y
                }
                // Select and move tools handled on individual bubbles in MapView.
            }
        
        ZoomingScrollView {
            MapView(map: map, selectedBubble: $selectedBubble, tool: tool, showConfirmation: $showConfirmation)
        }
        .gesture(tap)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar { bottomToolbar }
        .toolbar {
            ToolbarItem(placement: .principal) {
                if let linkedBubble = map.linkedBubble {
                    Button(action: {selectedBubble = map.linkedBubble!; sheet = .bubbleDetails}) {
                        BubbleCapsule(bubble: linkedBubble)
                            .labelStyle(.titleAndIcon)
                    }
                }
                else {
                    Text(map.name!)
                }
            }
        }
        .sheet(item: $sheet, onDismiss: sheetDismiss) {item in
            switch item {
            case .addBubble: AddBubbleSheet(selectedBubble: $selectedBubble, added: $addMappedBubble).presentationDetents([.fraction(0.3)])
            case .bubbleList: SelectionBubbleList(selection: $selectedBubble, selected: $addMappedBubble)
            case .bubbleDetails: UnknownBubbleView(bubble: Binding($selectedBubble)!)
            }
        }
        .confirmationDialog("", isPresented: $showConfirmation, presenting: selectedBubble) {detail in
            Button(action: { sheet = .bubbleDetails }) {
                Text("Show Details")
            }
            Button(role: .destructive, action: { context.delete(selectedBubble!) }) {
                Text("Delete")
            }
        }
    }
    
    func sheetDismiss() {
        if addMappedBubble {
            let mappedBubble = MappedBubble(context: context)
            mappedBubble.bubble = selectedBubble
            mappedBubble.x = x
            mappedBubble.y = y
            map.addToMappedBubbles(mappedBubble)
            addMappedBubble = false
        }
    }
}

enum Tool: String, Identifiable, CaseIterable {
    case select = "Select", move = "Move Bubble", newBubble = "New Bubble", linkBubble = "Existing Bubble"
    var id: RawValue { rawValue }
    var imageName: String {
        switch self {
        case .select: return "cursorarrow"
        case .move: return "dot.arrowtriangles.up.right.down.left.circle"
        // case .move: return "arrow.up.and.down.and.arrow.left.and.right"
        case .newBubble: return "plus.circle"
        case .linkBubble: return "link.circle"
        }
    }
}

enum MapShownSheet: String, Identifiable {
    case addBubble, bubbleList, bubbleDetails
    var id: RawValue { rawValue }
}
