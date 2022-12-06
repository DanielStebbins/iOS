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
                    sheet = .addBubble
                    x = value.location.x
                    y = value.location.y
                }
                else if tool == .linkBubble {
                    sheet = .bubbleList
                    x = value.location.x
                    y = value.location.y
                }
                // Select tool handled on individual bubbles in MapView.
            }
        
        ZoomingScrollView {
            MapView(map: map, selectedBubble: $selectedBubble, selecting: tool == .select, showConfirmation: $showConfirmation)
        }
        .gesture(tap)
        .navigationTitle(map.name!)
        .navigationBarTitleDisplayMode(.inline)
        .sheet(item: $sheet, onDismiss: sheetDismiss) {item in
            switch item {
            case .addBubble: AddBubbleSheet(selectedBubble: $selectedBubble, added: $addMappedBubble).presentationDetents([.fraction(0.3)])
            case .bubbleList: SelectionBubbleList(selection: $selectedBubble, selected: $addMappedBubble)
            case .bubbleDetails: UnknownBubbleView(bubble: Binding($selectedBubble)!)
            }
        }
        .toolbar { toolbar }
        .confirmationDialog("", isPresented: $showConfirmation, presenting: selectedBubble) {detail in
            Button(action: { sheet = .bubbleDetails }) {
                Text("Show Details")
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

enum MapShownSheet: String, Identifiable {
    case addBubble, bubbleList, bubbleDetails
    var id: RawValue { rawValue }
}
