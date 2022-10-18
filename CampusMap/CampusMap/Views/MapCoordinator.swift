//
//  MapCoordinator.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/17/22.
//

import Foundation
import MapKit

class MapCoordinator: NSObject, MKMapViewDelegate {
    let manager: Manager
    let map: MKMapView
    
    init(manager: Manager, map: MKMapView) {
        self.manager = manager
        self.map = map
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        switch annotation {
        case is MKUserLocation: return nil
        case is Building:
            let building = annotation as! Building
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "")
            marker.markerTintColor = building.isFavorite! ? .yellow : .blue
            marker.canShowCallout = true
            marker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return marker
        case is Pin:
            let marker = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "")
            marker.markerTintColor = .red
            marker.canShowCallout = true
            marker.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            return marker
        default: return nil
        }
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let marker = view as! MKMarkerAnnotationView
        switch marker.markerTintColor {
        case UIColor.red:
            let pin = view.annotation as! Pin
            manager.selectedPin = pin
            manager.shownSheet = .pin
        case UIColor.yellow, UIColor.blue:
            let building = view.annotation as! Building
            manager.selectedBuilding = building
            manager.shownSheet = .building
        default: return
        }
    }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let polyline = overlay as! MKPolyline
        let renderer = MKPolylineRenderer(polyline: polyline)
        renderer.strokeColor = UIColor.blue
        renderer.lineWidth = 6
        return renderer
    }
    
    @objc func addPin(recognizer: UILongPressGestureRecognizer) {
        guard recognizer.state == .began else {return}
        let view = recognizer.view as! MKMapView
        let point = recognizer.location(in: view)
        let coordinate = view.convert(point, toCoordinateFrom: view)
        
        let pin = Pin(coordinate: coordinate)
        manager.pins.append(pin)
        manager.adjustRegion()
        view.addAnnotation(pin)
    }
}
