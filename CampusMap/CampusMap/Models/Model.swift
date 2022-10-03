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
        print(buildings.filter({ $0.isShown! == true }))
        return buildings.filter({ $0.isShown! == true })
    }
    
    init() {
        var tempBuildings : [Building] = []
        let url = Bundle.main.url(forResource: "buildings", withExtension: "json")!
        do {
            let data = try Data(contentsOf: url)
            tempBuildings = try JSONDecoder().decode([Building].self, from: data)
        } catch   {
            print("Error decoding buildings: \(error)")
            tempBuildings = []
        }
        // The initial dataset does not include a favorite boolean.
        for i in tempBuildings.indices {
            tempBuildings[i].isShown = tempBuildings[i].isShown ?? false
            tempBuildings[i].isFavorite = tempBuildings[i].isFavorite ?? false
        }
        
        // TEST PIN, DELETE
        let index = tempBuildings.firstIndex(where: { $0.name == "Chemistry Building" })!
        tempBuildings[index].isShown = true
        
        buildings = tempBuildings.sorted(by: { $0.name < $1.name })
    }
}
