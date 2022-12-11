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
