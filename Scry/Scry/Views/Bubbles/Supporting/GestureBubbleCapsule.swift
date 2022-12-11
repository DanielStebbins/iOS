//
//  GestureBubbleCapsule.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/8/22.
//

import SwiftUI

struct GestureBubbleCapsule: View {
    @ObservedObject var mappedBubble: MappedBubble
    @Binding var selectedMappedBubble: MappedBubble?
    var tool: Tool
    @Binding var showConfirmation: Bool
    
    @State private var initial = CGPoint.zero
    
    var body: some View {
        let selected: Bool = selectedMappedBubble == mappedBubble
        
        let move = DragGesture()
            .onChanged {value in
                if initial == CGPoint.zero {
                    initial = CGPoint(x: mappedBubble.x, y: mappedBubble.y)
                }
                mappedBubble.x = initial.x + value.translation.width
                mappedBubble.y = initial.y + value.translation.height
            }
            .onEnded { value in
                initial = CGPoint.zero
            }
        
        let tap = TapGesture()
            .onEnded {
                if !selected {
                    selectedMappedBubble = mappedBubble
                    mappedBubble.lastChanged = Date.now
                }
                else {
                    selectedMappedBubble = nil
                }
            }
        
        let press = LongPressGesture(maximumDistance: 3)
            .onEnded { _ in
                if selected {
                    showConfirmation = true
                }
                else {
                    toggleRelationship()
                }
            }
        
        // If condition fixes timing problem on mappedBubble deletion.
        if let bubble = mappedBubble.bubble {
            // Never touch the order of these view modifiers. Will cause crashing.
            BubbleCapsule(bubble: bubble, size: mappedBubble.fontSize)
                .overlay {
                    if selected {
                        Capsule()
                            .stroke(Color.accentColor, lineWidth: 2)
                    }
                }
                .font(.system(size: mappedBubble.fontSize))
                .position(x: mappedBubble.x, y: mappedBubble.y)
                .gesture(selected ? move : nil)
                .gesture(tool == .select ? tap : nil)
                .simultaneousGesture(selectedMappedBubble != nil ? press : nil)
        }
    }
    
    func toggleRelationship() {
        switch mappedBubble.bubble {
        case let current as Character: current.toggleRelationship(bubble: selectedMappedBubble!.bubble!)
        case let current as Faction: current.toggleRelationship(bubble: selectedMappedBubble!.bubble!)
        case let current as Item: current.toggleRelationship(bubble: selectedMappedBubble!.bubble!)
        case let current as Location: current.toggleRelationship(bubble: selectedMappedBubble!.bubble!)
        default: return
        }
    }
}
