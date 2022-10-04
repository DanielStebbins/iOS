//
//  Model.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import Foundation

struct Model {
    let centerLatitude: Double = 40.7982
    let centerLongitude: Double = -77.8599
    var buildings: [Building]
    
    var shown: [Building] {
        return buildings.filter({ $0.isShown! == true })
    }
    
    private let storageManager: StorageManager<[Building]>
    init() {
        storageManager = StorageManager(name: "buildings")
        var tempBuildings = storageManager.modelData ?? []
        
        // The initial dataset does not include a favorite boolean.
        for i in tempBuildings.indices {
            tempBuildings[i].isShown = tempBuildings[i].isShown ?? false
            tempBuildings[i].isFavorite = tempBuildings[i].isFavorite ?? false
        }
        buildings = tempBuildings.sorted(by: { $0.name < $1.name })
    }
    
    func save() {
        storageManager.save(modelData: buildings)
    }
}
