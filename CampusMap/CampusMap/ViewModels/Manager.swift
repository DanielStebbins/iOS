//
//  Manager.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import Foundation
import MapKit
import SwiftUI

class Manager: NSObject, ObservableObject {
    @Published var model: Model
    @Published var region : MKCoordinateRegion
    @Published var selectedBuilding: Building?
    @Published var showConfirmation: Bool = false
    @Published var shownSheet: ActiveSheet?
    @Published var tracking: MapUserTrackingMode = .none
    @Published var listedBuildings: ListedBuildings = .all
    @Published var walkingTime: String = "Unknown Time"
    
    var span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    let locationManager : CLLocationManager
    var lastUserLocation: CLLocation?
    
    override init() {
        let tempModel = Model()
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: tempModel.centerLatitude, longitude: tempModel.centerLongitude), span: span)
        self.model = tempModel
        locationManager = CLLocationManager()
        
        super.init()
        
        locationManager.desiredAccuracy = .leastNonzeroMagnitude
        locationManager.delegate = self
    }
    
    func isListed(building: Building) -> Bool {
        switch listedBuildings {
        case .all: return true
        case .favorites: return building.isFavorite!
        case .nearby: return distance(from: building) < 400
        }
    }
    
    // In meters.
    func distance(from building: Building) -> Double {
        let buildingLocation = CLLocation(latitude: building.latitude, longitude: building.longitude)
        let currentLocation: CLLocation
        if let user = lastUserLocation {
            currentLocation = user
        } else {
            currentLocation = CLLocation(latitude: region.center.latitude, longitude: region.center.longitude)
        }
        return buildingLocation.distance(from: currentLocation)
    }
    
    func timeToSelectedBuilding() {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: selectedBuilding!.cll2d))
        request.transportType = .walking
        
        let directions = MKDirections(request: request)
        directions.calculate { response, error in
            guard error == nil else {return}
            if let route = response?.routes.first {
                let formatter = DateComponentsFormatter()
                formatter.unitsStyle = .abbreviated
                formatter.includesApproximationPhrase = false
                formatter.includesTimeRemainingPhrase = false
                formatter.allowedUnits = [.minute, .second]
                self.walkingTime = formatter.string(from: route.expectedTravelTime) ?? "Unknown Time"
            }
        }
    }
    
    func headingToSelectedBuilding() -> Angle {
        let lat1 = lastUserLocation!.coordinate.latitude * Double.pi / 180
        let lon1 = lastUserLocation!.coordinate.longitude * Double.pi / 180

        let lat2 = selectedBuilding!.cll2d.latitude * Double.pi / 180
        let lon2 = selectedBuilding!.cll2d.longitude * Double.pi / 180

        let dLon = lon2 - lon1
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)

        return Angle(degrees: -atan2(x, y) * 180 / Double.pi)
    }
    
    func adjustRegion() {
        if(!model.shown.isEmpty || lastUserLocation != nil) {
            var topLeft: CLLocationCoordinate2D
            var bottomRight: CLLocationCoordinate2D
            if let user = lastUserLocation {
                topLeft = user.coordinate
                bottomRight = user.coordinate
            } else {
                topLeft = model.shown[0].cll2d
                bottomRight = model.shown[0].cll2d
            }
            
            for building in model.shown {
                topLeft.latitude = max(topLeft.latitude, building.latitude)
                topLeft.longitude = min(topLeft.longitude, building.longitude)
                bottomRight.latitude = min(bottomRight.latitude, building.latitude)
                bottomRight.longitude = max(bottomRight.longitude, building.longitude)
            }
            
            if(topLeft == bottomRight) {
                if(tracking == .none) {
                    region.center = topLeft
                }
                region.span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            } else {
                if(tracking == .none) {
                    region.center.latitude = (topLeft.latitude + bottomRight.latitude) / 2
                    region.center.longitude = (topLeft.longitude + bottomRight.longitude) / 2
                }
                region.span = MKCoordinateSpan.init(latitudeDelta: abs(topLeft.latitude - bottomRight.latitude) * 1.2, longitudeDelta: abs(bottomRight.longitude - topLeft.longitude) * 1.2)
            }
        }
    }
    
    func toggleFavorite() {
        guard let index = model.buildings.firstIndex(of: selectedBuilding!) else {return}
        model.buildings[index].isFavorite!.toggle()
        selectedBuilding!.isFavorite!.toggle()
    }
    
    func hideAll() {
        for i in model.buildings.indices {
            model.buildings[i].isShown = false
        }
        adjustRegion()
    }
    
    func showFavorites() {
        for i in model.buildings.indices {
            if model.buildings[i].isFavorite! {
                model.buildings[i].isShown = true
            }
        }
        adjustRegion()
    }
    
    func hideFavorites() {
        for i in model.buildings.indices {
            if model.buildings[i].isFavorite! {
                model.buildings[i].isShown = false
            }
        }
        adjustRegion()
    }
    
    func save() {
        model.save()
    }
}

enum ActiveSheet: String, Identifiable {
    case details, buildingList
    var id: RawValue { rawValue }
}

extension Building {
    var cll2d : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}

extension CLLocationCoordinate2D: Equatable {
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

enum ListedBuildings: String, Identifiable, CaseIterable {
    case all, favorites, nearby
    var id: RawValue { rawValue }
}
