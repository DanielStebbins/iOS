//
//  GestureMapView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/10/22.
//

import SwiftUI

struct ToolbarMapView: View {
    @ObservedObject var map: Map
    let mapMenuFullyOpen: Bool
    let closeMapMenu: () -> Void
    
    @State var tool: Tool = .select
    @State var selectedMappedBubble = SelectedWrapper()
    @State var drawColor: Color = Color.randomDarkColor
    @State var drawSize: Size = .medium
    
    var body: some View {
        let defaultToolbar = ToolbarItemGroup(placement: .bottomBar) {
            Spacer()
            ToolPicker(tool: $tool, selectedMappedBubble: selectedMappedBubble)
                .disabled(mapMenuFullyOpen)
            Spacer()
        }
        
        let drawToolbar = ToolbarItemGroup(placement: .bottomBar) {
            SizePicker(size: $drawSize)
                .disabled(mapMenuFullyOpen)
            Spacer()
            ToolPicker(tool: $tool, selectedMappedBubble: selectedMappedBubble)
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
            ToolPicker(tool: $tool, selectedMappedBubble: selectedMappedBubble)
                .disabled(mapMenuFullyOpen)
            Spacer()
        }
        
        GestureMapView(map: map, mapMenuFullyOpen: mapMenuFullyOpen, closeMapMenu: { closeMapMenu() }, selectedMappedBubble: selectedMappedBubble, tool: tool, drawColor: drawColor, drawSize: drawSize)
            .toolbar {
                switch(tool) {
                case .draw: drawToolbar
                case .erase: eraseToolbar
                default: defaultToolbar
                }
            }
    }
}

class SelectedWrapper: ObservableObject {
//    @Published var selected: MappedBubble? {
//        didSet {
//            points = []
//        }
//    }
//    @Published var points: [MappedBubble] = []
    @Published var selected: MappedBubble?
//    @Published var flag: Bool = false
}

enum Tool: String, Identifiable, CaseIterable {
    case select = "Select", addBubble = "Add Bubble", draw = "Draw", erase = "Erase"
    var id: RawValue { rawValue }
    var imageName: String {
        switch self {
        case .select: return "cursorarrow"
        case .addBubble: return "plus.circle"
        case .draw: return "scribble.variable"
        case .erase: return "trash.square"
        }
    }
}

struct ToolPicker: View {
    @Binding var tool: Tool
    @ObservedObject var selectedMappedBubble: SelectedWrapper
    
    var body: some View {
        Picker("Tool", selection: $tool) {
            ForEach(Tool.allCases) {
                Label($0.rawValue, systemImage: $0.imageName).tag($0).imageScale(.large)
            }
        }
        .onChange(of: tool) { _ in
            selectedMappedBubble.selected = nil
        }
        .pickerStyle(.menu)
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
