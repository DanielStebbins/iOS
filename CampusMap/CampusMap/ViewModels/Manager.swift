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
    @Published var shownSheet: ActiveSheet?
    
    let span = 0.01
    
    init() {
        let tempModel = Model()
        region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: tempModel.centerLatitude, longitude: tempModel.centerLongitude), span: MKCoordinateSpan(latitudeDelta: span, longitudeDelta: span))
        self.model = tempModel
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
    }
    
    func showFavorites() {
        for i in model.buildings.indices {
            if model.buildings[i].isFavorite! {
                model.buildings[i].isShown = true
            }
        }
    }
    
    func hideFavorites() {
        for i in model.buildings.indices {
            if model.buildings[i].isFavorite! {
                model.buildings[i].isShown = false
            }
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

extension Building {
    var cll2d : CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: self.latitude, longitude: self.longitude)
    }
}
