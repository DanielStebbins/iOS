//
//  Delegate.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/10/22.
//

import Foundation
import CoreLocation

extension Manager : CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        default:
            locationManager.stopUpdatingLocation()
        }
    }
    

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let firstLocation = locations[0]
            lastUserLocation = firstLocation
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    }
    
    // For use by SwiftUI's LocationButton
    func requestLocation() {
        locationManager.requestLocation()
    }

}
