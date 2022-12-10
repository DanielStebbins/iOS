//
//  ScrollingMapView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/30/22.
//

import SwiftUI

struct ScrollingMapView: View {
    @ObservedObject var map: Map
    let mapMenuFullyOpen: Bool
    let closeMapMenu: () -> Void
    
    @State var tool: Tool = .select
    @State var sheet: MapShownSheet?
    @State var x: Double = 0.0
    @State var y: Double = 0.0
    @State var selectedMappedBubble: MappedBubble?
    @State var sheetBubble: Bubble?
    @State var showSelectConfirmation: Bool = false
    @State var addMappedBubble: Bool = false
    @State var showAddConfirmation: Bool = false
    
    @State var drawColor: Color = Color.randomDarkColor
    @State var drawSize: Size = .medium
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let defaultToolbar = ToolbarItemGroup(placement: .bottomBar) {
            Spacer()
            ToolPicker(tool: $tool, selectedMappedBubble: $selectedMappedBubble)
                .disabled(mapMenuFullyOpen)
            Spacer()
        }
        
        let drawToolbar = ToolbarItemGroup(placement: .bottomBar) {
            SizePicker(size: $drawSize)
                .disabled(mapMenuFullyOpen)
            Spacer()
            ToolPicker(tool: $tool, selectedMappedBubble: $selectedMappedBubble)
                .disabled(mapMenuFullyOpen)
            Spacer()
            ColorPicker("", selection: $drawColor)
                .labelsHidden()
                .disabled(mapMenuFullyOpen)
        }
        
        let eraseToolbar = ToolbarItemGroup(placement: .bottomBar) {
            SizePicker(size: $drawSize)
                .disabled(mapMenuFullyOpen)
            Spacer()
            ToolPicker(tool: $tool, selectedMappedBubble: $selectedMappedBubble)
                .disabled(mapMenuFullyOpen)
            Spacer()
        }
        
        let tap = SpatialTapGesture()
            .onEnded { value in
                if mapMenuFullyOpen {
                    closeMapMenu()
                }
                else {
                    x = value.location.x
                    y = value.location.y
                    switch tool {
                        // Selecting and moving handled on individual bubbles with GesturedCapsule.
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
                let new = selectedMappedBubble!.fontSize * Double(change)
                selectedMappedBubble!.fontSize = min(max(new, 7), 30)
            }
        
        ZoomingScrollView {
            MapView(map: map, selectedMappedBubble: $selectedMappedBubble, tool: tool, showConfirmation: $showSelectConfirmation)
                .gesture(tool == .select && selectedMappedBubble != nil ? resize : nil)
                .gesture(tool == .draw || tool == .erase ? drag : nil)
                .gesture(tap)
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            switch(tool) {
            case .draw: drawToolbar
            case .erase: eraseToolbar
            default: defaultToolbar
            }
        }
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
            case .bubbleList: SelectionBubbleList(selection: $sheetBubble, selected: $addMappedBubble)
            case .bubbleDetails: UnknownBubbleView(bubble: Binding(Binding($selectedMappedBubble)!.bubble)!)
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
            let mappedBubble = MappedBubble(context: context)
            mappedBubble.bubble = sheetBubble
            mappedBubble.x = x
            mappedBubble.y = y
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

struct ToolPicker: View {
    @Binding var tool: Tool
    @Binding var selectedMappedBubble: MappedBubble?
    
    var body: some View {
        Picker("Tool", selection: $tool) {
            ForEach(Tool.allCases) {
                Label($0.rawValue, systemImage: $0.imageName).tag($0).imageScale(.large)
            }
        }
        .onChange(of: tool) { _ in
            selectedMappedBubble = nil
        }
        .pickerStyle(.menu)
    }
}

struct SizePicker: View {
    @Binding var size: Size
    
    var body: some View {
        Menu {
            ForEach(Size.allCases, id:\.self) { s in
                Button(action: { size = s }) {
                    HStack {
                        Text(s.rawValue)
                        if size == s {
                            Image(systemName: "checkmark")
                        }
                    }
                }
                .buttonStyle(.bordered)
            }
        } label: {
            Image(systemName: "circle.fill")
                .imageScale(size.imageScale)
        }
    }
}

enum Tool: String, Identifiable, CaseIterable {
    case select = "Select", addBubble = "Add Bubble", draw = "Draw", erase = "Erase"
    var id: RawValue { rawValue }
    var imageName: String {
        switch self {
        case .select: return "cursorarrow"
//        case .move: return "arrow.up.and.down.and.arrow.left.and.right"
        case .addBubble: return "plus.circle"
        case .draw: return "scribble.variable"
        case .erase: return "trash.square"
        }
    }
}

enum Size: String, Identifiable, CaseIterable {
    case small = "Small", medium = "Medium", large = "Large"
    var id: RawValue { rawValue }
    var imageScale: Image.Scale {
        switch self {
        case .small: return Image.Scale.small
        case .medium: return Image.Scale.medium
        case .large: return Image.Scale.large
        }
    }
    var radius: Double {
        switch self {
        case .small: return 5
        case .medium: return 10
        case .large: return 20
        }
    }
}

enum MapShownSheet: String, Identifiable {
    case newBubble, bubbleList, bubbleDetails
    var id: RawValue { rawValue }
}
