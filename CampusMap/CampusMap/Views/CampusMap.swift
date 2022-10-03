//
//  CampusMap.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import SwiftUI
import MapKit

struct CampusMap: View {
    @EnvironmentObject var manager : Manager
    var body: some View {
        Map(coordinateRegion: $manager.region, annotationItems: manager.model.shown, annotationContent: annotationFor(building:))
    }
    
    func annotationFor(building: Building) -> some MapAnnotationProtocol {
        MapAnnotation(coordinate: building.cll2d) {
            Button(action: {
                manager.selectedBuilding = building
                manager.showConfirmation = true
            }) {
                Image(systemName: "mappin.circle.fill")
                    .foregroundColor(building.isFavorite! ? .yellow : .blue)
                    .font(.system(size: 40))
            }
        }
    }
}

struct CampusMap_Previews: PreviewProvider {
    static var previews: some View {
        CampusMap()
    }
}
