//
//  Pentominoes.swift
//  Assets for Assignment 4
//
//  Created by Hannan, John Joseph on 9/7/22.
//

import Foundation

struct Model {
    let tiles: [Tile] = StorageManager.readTiles(file: "Tiles")
    let solutions: [[String: Position]] = StorageManager.readSolutions(file: "Solutions")
}

// A tile with width/height in unit coordinates
struct Tile: Codable {
    let name: String
    let width: Int
    let height: Int
    
    static let standard = Tile(name: "I", width: 1, height: 4)
}

// Specifies the complete orientation of a piece using unit coordinates
struct Position: Codable {
    var x: Int
    var y: Int
    var isFlipped : Bool
    var rotations : Int
    
    init() {
        x = 0
        y = 0
        isFlipped = false
        rotations = 0
    }
}

// A Piece is the model data that the view uses to display a pentomino
struct Piece {
    let tile: Tile
    var position: Position
    
    static let standard = Piece(tile: Tile.standard, position: Position())
}


