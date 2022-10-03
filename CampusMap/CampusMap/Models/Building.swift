//
//  Building.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import Foundation

struct Building: Codable, Identifiable, Equatable {
    let latitude: Double
    let longitude: Double
    let name: String
    let opp_bldg_code: Int
    let year_constructed: Int?
    var isShown: Bool?
    var isFavorite: Bool?
    var id: String { name }
}
