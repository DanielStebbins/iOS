//
//  Model.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import Foundation

struct Coordinate {
    var latitude : Double
    var longitude : Double
}

struct Model {
    let center: Coordinate
    var buildings: [Building]
    
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
        let centerBuilding = tempBuildings.first(where: { $0.name == "Chemistry Building" })!
        
        center = Coordinate(latitude: centerBuilding.latitude, longitude: centerBuilding.longitude)
        buildings = tempBuildings
    }
    
//    let favorites : [Spot] =
//        [Spot(coord: Coord(latitude: 40.79550030, longitude: -77.85900170), title: "Cheese Shoppe") ,
//         Spot(coord: Coord(latitude: +40.79414797, longitude: -77.86152899), title: "The Corner Room")]
    
}
