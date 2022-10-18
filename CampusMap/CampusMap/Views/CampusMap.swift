//
//  CampusMap.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import SwiftUI
import MapKit


struct CampusMap: UIViewRepresentable {
    @ObservedObject var manager: Manager
    let mapView = MKMapView()
    
    func makeUIView(context: Context) -> MKMapView {
        mapView.mapType = .standard
        mapView.showsUserLocation = true
        mapView.preferredConfiguration = manager.mapType
        mapView.userTrackingMode = manager.tracking
        mapView.delegate = context.coordinator
        
        let longPress = UILongPressGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.addPin(recognizer:)))
        mapView.addGestureRecognizer(longPress)
        
        let pan = UIPanGestureRecognizer(target: context.coordinator, action: #selector(context.coordinator.stopFollow(recognizer:)))
        mapView.addGestureRecognizer(pan)
        
        return mapView
    }
    
    func updateUIView(_ mapView: MKMapView, context: Context) {
        mapView.setRegion(manager.region, animated: true)
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotations(manager.model.shown)
        mapView.addAnnotations(manager.pins)
        mapView.preferredConfiguration = manager.mapType
        print(manager.tracking)
        mapView.userTrackingMode = manager.tracking
    
//        mapView.removeOverlays(mapView.overlays)
//        mapView.addOverlays(manager.routes)
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(manager: manager, map: mapView)
    }
}
