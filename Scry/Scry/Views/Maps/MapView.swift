//
//  MapView.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/23/22.
//

import SwiftUI

struct MapView: View {
    @ObservedObject var map: Map
    @Binding var selectedBubble: Bubble?
    var tool: Tool
    @Binding var showConfirmation: Bool
    
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let uiImage = map.image == nil ? UIImage(imageLiteralResourceName: "square-grid") : UIImage(data: map.image!)!
        
        let bubbleSet: NSSet = map.mappedBubbles!
        let mappedBubbles: [MappedBubble] = bubbleSet.allObjects as! [MappedBubble]
        
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
            ForEach(mappedBubbles) { mappedBubble in
                GestureBubbleCapsule(mappedBubble: mappedBubble, selectedBubble: $selectedBubble, tool: tool, showConfirmation: $showConfirmation)
            }
        }
    }
}
