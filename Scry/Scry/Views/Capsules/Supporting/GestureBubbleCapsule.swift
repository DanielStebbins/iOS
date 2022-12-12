//
//  GestureBubbleCapsule.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/8/22.
//

import SwiftUI

// Runs all of the gestures that happen on a MappedBubble.
// Gestures that involve the whole map, like resize, happen in GestureMapView.
struct GestureBubbleCapsule: View {
    @ObservedObject var mappedBubble: MappedBubble
    @Binding var selectedMappedBubble: MappedBubble?
    var tool: Tool
    @Binding var showConfirmation: Bool
    
    @State private var initial = CGPoint.zero
    
    var body: some View {
        // Boolean for whether this bubble is the selected bubble.
        let selected: Bool = selectedMappedBubble == mappedBubble
        
        // Drag moving (only if selected).
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
        
        // Tapping selects and de-selects.
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
        
        // Long press brings up options if selected, creates a new relationship with the selected if not.
        let press = LongPressGesture(minimumDuration: 0.75, maximumDistance: 3)
            .onEnded { _ in
                if selected {
                    showConfirmation = true
                }
                else {
                    toggleRelationship()
                    // Changing the relationships wasn't updating the lines, this line forces a redraw.
                    selectedMappedBubble!.bubble = selectedMappedBubble!.bubble!
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
    
    // Makes or breaks a relationship between this bubble and the selected bubble.
    func toggleRelationship() {
        switch selectedMappedBubble!.bubble! {
        case let character as Character: character.toggleRelationship(bubble: mappedBubble.bubble!)
        case let faction as Faction: faction.toggleRelationship(bubble: mappedBubble.bubble!)
        case let item as Item: item.toggleRelationship(bubble: mappedBubble.bubble!)
        case let location as Location: location.toggleRelationship(bubble: mappedBubble.bubble!)
        default: return
        }
    }
}
