//
//  MapTypeMenu.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/17/22.
//

import SwiftUI
import MapKit

struct MapTypeMenu: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        Menu {
                Button("Standard") {
                    manager.mapType = MKStandardMapConfiguration()
                }
                .buttonStyle(.bordered)
                Button("Hybrid") {
                    manager.mapType = MKHybridMapConfiguration()
                }
                .buttonStyle(.bordered)
                Button("Imagery") {
                    manager.mapType = MKImageryMapConfiguration()
                }
                .buttonStyle(.bordered)
        } label: {
            Image(systemName: "globe")
        }

    }
}

struct MapTypeMenu_Previews: PreviewProvider {
    static var previews: some View {
        MapTypeMenu()
    }
}
