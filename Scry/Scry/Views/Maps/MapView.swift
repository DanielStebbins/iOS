//
//  MapView.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/23/22.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var map: Map
    @Binding var selectedMappedBubble: MappedBubble?
    var tool: Tool
    @Binding var showConfirmation: Bool
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let uiImage = map.image == nil ? UIImage(imageLiteralResourceName: "square-grid") : UIImage(data: map.image!)!
        
        let mappedBubbles: [MappedBubble] = map.mappedBubbles!.allObjects as! [MappedBubble]
        let sortedBubbles: [MappedBubble] = mappedBubbles.sorted(by: { $0.lastChanged! < $1.lastChanged! })
        
        let drawnCircles: [DrawnCircle] = map.drawnCircles!.allObjects as! [DrawnCircle]
        let sortedCircles: [DrawnCircle] = drawnCircles.sorted(by: { $0.created! < $1.created! })
        
        ZStack(alignment: .leading) {
            // Needed to stop the ZStack from resizing if there are no annotations.
            Color.mapBackground
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFit()
            ForEach(sortedCircles) { circle in
                DrawnCircleView(circle: circle)
            }
            
            if let selected = selectedMappedBubble {
                RelationshipLines(selected: selected, bubbles: sortedBubbles)
            }
            
            // I separated out the selectedMappedBubble so it will be displayed on top.
            ForEach(sortedBubbles) { mappedBubble in
                GestureBubbleCapsule(mappedBubble: mappedBubble, selectedMappedBubble: $selectedMappedBubble, tool: tool, showConfirmation: $showConfirmation)
            }
        }
    }
}

struct RelationshipLines: View {
    @ObservedObject var selected: MappedBubble
    let bubbles: [MappedBubble]
    
    var body: some View {
        ForEach(bubbles) { b in
            RelationshipLine(current: b, selected: selected)
        }
    }
}

struct RelationshipLine: View {
    let current: MappedBubble
    @ObservedObject var selected: MappedBubble
    
    var body: some View {
        let color = lineColor()
        if color != .clear {
            Path { path in
                path.move(to: CGPoint(x: current.x, y: current.y))
                path.addLine(to: CGPoint(x: selected.x, y: selected.y))
            }
            .stroke(color, lineWidth: 2)
        }
    }
    
    func lineColor() -> Color {
        switch current.bubble {
        case let current as Character: return current.relationshipColor(bubble: selected.bubble!)
        case let current as Faction: return current.relationshipColor(bubble: selected.bubble!)
        case let current as Item: return current.relationshipColor(bubble: selected.bubble!)
        case let current as Location: return current.relationshipColor(bubble: selected.bubble!)
        default: return Color.clear
        }
    }
}
