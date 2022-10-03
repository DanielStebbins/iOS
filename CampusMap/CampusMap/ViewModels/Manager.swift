//
//  Manager.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import Foundation
import MapKit

class Manager  : ObservableObject {
    @Published var model: Model
    @Published var region : MKCoordinateRegion
    let span = 0.01
    
    init() {
        let _model = Model()
        region = MKCoordinateRegion(center: _model.center.cll2d, span: MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span))
        self.model = _model
    }
}

extension Coordinate {
    var cll2d : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
