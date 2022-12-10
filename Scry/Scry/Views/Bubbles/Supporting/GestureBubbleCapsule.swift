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
    
    @State private var offset = CGSize.zero
    
    var body: some View {
        let selected: Bool = selectedMappedBubble == mappedBubble
        
        let move = DragGesture()
            .onChanged {value in
                offset = value.translation
            }
            .onEnded { value in
                mappedBubble.x += value.translation.width
                mappedBubble.y += value.translation.height
                offset = CGSize.zero
            }
        
        let tap = TapGesture()
            .onEnded {
                if !selected {
                    selectedMappedBubble = mappedBubble
                }
                else {
                    showConfirmation = true
                }
            }
        
        // If condition fixes timing problem on mappedBubble deletion.
        if let bubble = mappedBubble.bubble {
            // Never touch the order of these view modifiers. Will cause crashing.
            BubbleCapsule(bubble: bubble)
                .overlay {
                    if selected {
                        Capsule()
                            .stroke(Color.accentColor, lineWidth: 2)
                    }
                }
                .font(.system(size: mappedBubble.fontSize))
                .position(x: mappedBubble.x, y: mappedBubble.y)
                .offset(offset)
                .gesture(selected ? move : nil)
                .gesture(tool == .select ? tap : nil)
        }
    }
}
