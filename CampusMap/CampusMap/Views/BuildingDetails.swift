//
//  BuildingDetailsView.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/3/22.
//

import SwiftUI

struct BuildingDetails: View {
    var building : Building?
        
    private var title : String {
        guard building != nil else {return "Unknown"}
        return building!.name
    }
    
    private var isFavorite : Bool {
        guard building != nil else {return false}
        return building!.isFavorite!
    }
    
    @State var angle = 90.0
    var repeatingAnimation: Animation {
        Animation
            .easeInOut(duration: 2)
            .repeatForever()
    }
    
    var body: some View {
        
        return VStack {
            Image(systemName: isFavorite ? "star.fill" : "circle.grid.hex.fill")
                .font(.system(size:80))
                .padding()
                .rotationEffect(.degrees(angle))
                .foregroundColor(isFavorite ? .yellow : .cyan)
            Text(title)
                .font(.system(size:30))
        }
        .onAppear {
            withAnimation(self.repeatingAnimation) { self.angle = -90 }
        }
    }
}

struct BuildingDetails_Previews: PreviewProvider {
    static var previews: some View {
        BuildingDetails()
    }
}
