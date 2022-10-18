//
//  Pin.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/17/22.
//

import Foundation
import MapKit

class Pin: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String? = "Pin"
//    var title: String? {
//        "Pin at \(round(coordinate.latitude * 10) / 10.0), \(round(coordinate.longitude * 10) / 10.0)"
//    }
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
