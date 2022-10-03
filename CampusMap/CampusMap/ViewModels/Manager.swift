//
//  Manager.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import Foundation
import MapKit

class Manager: ObservableObject {
    @Published var model: Model
    @Published var region : MKCoordinateRegion
    @Published var selectedBuilding: Building?
    @Published var showConfirmation: Bool = false
    @Published var showSheet: Bool = false
    
    let span = 0.01
    
    init() {
        let tempModel = Model()
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: tempModel.centerLatitude, longitude: tempModel.centerLongitude), span: MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span))
        self.model = tempModel
    }
    
    func toggleFavorite(_ building: Building) {
        guard let index = model.buildings.firstIndex(of: building) else {return}
        model.buildings[index].isFavorite!.toggle()
        print(model.buildings[index].isFavorite!)
    }
}

extension Building {
    var cll2d : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
