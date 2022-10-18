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
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}
