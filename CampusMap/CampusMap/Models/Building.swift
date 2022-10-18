//
//  Building.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import Foundation
import MapKit

class Building: NSObject, Codable, Identifiable, MKAnnotation {
    // Present in starting JSON.
    let latitude: Double
    let longitude: Double
    let name: String
    let opp_bldg_code: Int
    let photo: String?
    let year_constructed: Int?
    
    // Additional functionality.
    var isShown: Bool?
    var isFavorite: Bool?
    var id: String { name }
    var title : String? { name }
    var coordinate: CLLocationCoordinate2D { CLLocationCoordinate2D(latitude: latitude, longitude: longitude) }
}
