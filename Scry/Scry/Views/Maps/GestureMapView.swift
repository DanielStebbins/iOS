//
//  ScrollingMapView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/30/22.
//

import SwiftUI

struct GestureMapView: View {
    @ObservedObject var map: Map
    let mapMenuFullyOpen: Bool
    let closeMapMenu: () -> Void
    @Binding var selectedMappedBubble: MappedBubble?
    let tool: Tool
    let drawColor: Color
    let drawSize: Size

    @State var sheet: MapShownSheet?
    @State var x: Double = 0.0
    @State var y: Double = 0.0
    @State var sheetBubble: Bubble?
    @State var showSelectConfirmation: Bool = false
    @State var addMappedBubble: Bool = false
    @State var showAddConfirmation: Bool = false
    @State var previousResize: Double = -1.0

    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let tap = SpatialTapGesture()
            .onEnded { value in
                if mapMenuFullyOpen {
                    closeMapMenu()
                }
                else {
                    x = value.location.x
                    y = value.location.y
                    // Trying to fix it getting stuck some times saying "trying to present what's already presented.
                    showAddConfirmation = false
                    // Selecting and moving handled on individual bubbles with GesturedCapsule.
                    switch tool {
                    case .select: selectedMappedBubble = nil
                    case .addBubble: showAddConfirmation = true
                    case .draw: draw()
                    case .erase: erase()
                    }
                }
            }
        
        let drag = DragGesture()
            .onChanged { value in
                x = value.location.x
                y = value.location.y
                if tool == .draw {
                    draw()
                }
                else if tool == .erase {
                    erase()
                }
            }
            .onEnded { value in
                try? context.save()
            }
        
        let resize = MagnificationGesture()
            .onChanged { change in
                var c = Double(change)
                if previousResize != -1.0 {
                    c /= previousResize
                }
                let new = selectedMappedBubble!.fontSize * c
                selectedMappedBubble!.fontSize = min(max(new, 5), 40)
                previousResize = Double(change)
            }
            .onEnded { _ in
                previousResize = -1.0
            }
        
        
        ZoomingScrollView(zoom: selectedMappedBubble == nil) {
            MapView(map: map, selectedMappedBubble: $selectedMappedBubble, tool: tool, showConfirmation: $showSelectConfirmation)
                .gesture(tool == .select && selectedMappedBubble != nil ? resize : nil)
                .gesture(tool == .draw || tool == .erase ? drag : nil)
//                .gesture(tool == .select ? tap : nil)
                .gesture(tap)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                if let linkedBubble = map.linkedBubble {
                    Button(action: { sheetBubble = map.linkedBubble!; sheet = .bubbleDetails }) {
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
            case .newBubble: NewBubbleSheet(selectedBubble: $sheetBubble, added: $addMappedBubble).presentationDetents([.fraction(0.3)])
            case .bubbleList: SelectionBubbleList(selection: $sheetBubble, selected: $addMappedBubble, types: [.all])
            case .bubbleDetails: UnknownBubbleView(bubble: selectedMappedBubble!.bubble!)
            }
        }
        .confirmationDialog("", isPresented: $showSelectConfirmation, presenting: $selectedMappedBubble) {detail in
            Button(action: { sheet = .bubbleDetails }) {
                Text("Show Details")
            }
            Button(role: .destructive, action: { context.delete(selectedMappedBubble!) }) {
                Text("Delete")
            }
        }
        .confirmationDialog("", isPresented: $showAddConfirmation) {
            Button(action: { sheet = .newBubble }) {
                Text("New Bubble")
            }
            Button(action: { sheet = .bubbleList }) {
                Text("Existing Bubble")
            }
        }
    }
    
    func sheetDismiss() {
        if addMappedBubble {
            let mappedBubble = MappedBubble(context: context, bubble: sheetBubble!, x: x, y: y)
            map.addToMappedBubbles(mappedBubble)
            addMappedBubble = false
        }
    }
    
    func draw() {
        let circle = DrawnCircle(context: context)
        circle.x = x
        circle.y = y
        let components = drawColor.components
        circle.radius = drawSize.radius
        circle.red = Int16(components[0] * 255)
        circle.green = Int16(components[1] * 255)
        circle.blue = Int16(components[2] * 255)
        circle.opacity = components[3]
        circle.created = Date.now
        map.addToDrawnCircles(circle)
    }
        
    func erase() {
        map.erase(context: context, x: x, y: y, eraseRadius: drawSize.radius)
    }
}

enum MapShownSheet: String, Identifiable {
    case newBubble, bubbleList, bubbleDetails
    var id: RawValue { rawValue }
}
