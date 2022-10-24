//
//  Pokemon.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import Foundation

struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let height: Double
    let weight: Double
    let types: [PokemonType]
    let weaknesses: [PokemonType]
    let prevEvolution: [Int]?
    let nextEvolution: [Int]?
    
    var leadingZeroID: String {
        String(format: "%03d", id)
    }
}
