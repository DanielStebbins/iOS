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
        Map(coordinateRegion: $manager.region)
    }
}

struct CampusMap_Previews: PreviewProvider {
    static var previews: some View {
        CampusMap()
    }
}
