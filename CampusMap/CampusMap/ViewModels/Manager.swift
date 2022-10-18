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
    @Published var region: MKCoordinateRegion
    @Published var selectedBuilding: Building?
    @Published var shownSheet: ActiveSheet?
    @Published var tracking: MKUserTrackingMode = .none
    @Published var listedBuildings: ListedBuildings = .all
    
    @Published var route: MKPolyline?
    @Published var routedBuilding: Building?
    @Published var walkingTime: String = "Unknown Time"
    
    @Published var mapType: MKMapConfiguration = MKStandardMapConfiguration()
    
    @Published var pins = [Pin]()
    @Published var selectedPin: Pin?
    @Published var showConfirmation: Bool = false
    
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
    
    // Controls which buildings to display in the list.
    func isListed(building: Building) -> Bool {
        switch listedBuildings {
        case .all: return true
        case .favorites: return building.isFavorite!
        case .nearby: return distance(from: building) < 400
        }
    }
    
    // Gets the distance from the user to the given building.
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
    
    // Gets the walking time from the user to the selected building.
    func routeToSelectedBuilding() {
        let request = MKDirections.Request()
        request.source = MKMapItem.forCurrentLocation()
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: selectedBuilding!.coordinate))
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
                self.route = route.polyline
                self.routedBuilding = self.selectedBuilding
            }
        }
    }
    
    // Gets the angle to the selected building.
    func headingToSelectedBuilding() -> Angle {
        let lat1 = lastUserLocation!.coordinate.latitude * Double.pi / 180
        let lon1 = lastUserLocation!.coordinate.longitude * Double.pi / 180

        let lat2 = selectedBuilding!.coordinate.latitude * Double.pi / 180
        let lon2 = selectedBuilding!.coordinate.longitude * Double.pi / 180

        let dLon = lon2 - lon1
        let y = sin(dLon) * cos(lat2)
        let x = cos(lat1) * sin(lat2) - sin(lat1) * cos(lat2) * cos(dLon)

        return Angle(degrees: -atan2(x, y) * 180 / Double.pi)
    }
    
    // Centers and zooms the map to show all buildings and the user. Has a default zoom for when only one thing is shown.
    func adjustRegion() {
        if(!model.shown.isEmpty || lastUserLocation != nil) {
            var topLeft: CLLocationCoordinate2D
            var bottomRight: CLLocationCoordinate2D
            if let user = lastUserLocation {
                topLeft = user.coordinate
                bottomRight = user.coordinate
            } else {
                topLeft = model.shown[0].coordinate
                bottomRight = model.shown[0].coordinate
            }
            
            for building in model.shown {
                topLeft.latitude = max(topLeft.latitude, building.latitude)
                topLeft.longitude = min(topLeft.longitude, building.longitude)
                bottomRight.latitude = min(bottomRight.latitude, building.latitude)
                bottomRight.longitude = max(bottomRight.longitude, building.longitude)
            }
            
            for pin in pins {
                topLeft.latitude = max(topLeft.latitude, pin.coordinate.latitude)
                topLeft.longitude = min(topLeft.longitude, pin.coordinate.longitude)
                bottomRight.latitude = min(bottomRight.latitude, pin.coordinate.latitude)
                bottomRight.longitude = max(bottomRight.longitude, pin.coordinate.longitude)
            }
            
            if(topLeft == bottomRight) {
                if(tracking == .none) {
                    region.center = topLeft
                }
                region.span = MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.005)
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
        selectedBuilding = model.buildings[index]
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
    
    func deletePin() {
        guard let index = pins.firstIndex(of: selectedPin!) else {return}
        pins.remove(at: index)
        selectedPin = nil
        adjustRegion()
    }
    
    func toggleTracking() {
        if(tracking == .follow) {
            tracking = .none
        } else {
            tracking = .follow
        }
    }
    
    func save() {
        model.save()
    }
}

enum ActiveSheet: String, Identifiable {
    case details, buildingList
    var id: RawValue { rawValue }
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
