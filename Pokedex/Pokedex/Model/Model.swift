//
//  Model.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import Foundation

struct Model {
    var pokemon: [Pokemon]

    init() {
        pokemon = StorageManager.readFrom(file: "pokedex", into: [Pokemon].self) ?? []
    }
}
