//
//  Pentominoes.swift
//  Assets for Assignment 4
//
//  Created by Hannan, John Joseph on 9/7/22.
//

import Foundation

struct Model {
    let boardNames: [String] = ["Board0", "Board1", "Board2", "Board3", "Board4", "Board5"]
    var buttonNames: [String] {
        boardNames.map({ $0 + "button" })
    }
    let solutions: [[String: Position]]
    var pieces: [Piece]

    
    init() {
        let tiles = StorageManager.readFrom(file: "Tiles", into: [Tile].self) ?? []
        solutions = StorageManager.readFrom(file: "Solutions", into: [[String: Position]].self) ?? []
        
        var tempPieces: [Piece] = []
        for tile in tiles {
            tempPieces.append(Piece(tile: tile, position: Position()))
        }
        pieces = tempPieces
    }
}

// A tile with width/height in unit coordinates.
struct Tile: Codable {
    let name: String
    let width: Int
    let height: Int
    
    static let standard = Tile(name: "I", width: 1, height: 4)
}

// Specifies the complete orientation of a piece using unit coordinates.
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

// More x,y control.
extension Position {
    init(x: Int, y: Int) {
        self.x = x
        self.y = y
        isFlipped = false
        rotations = 0
    }
    
    mutating func moveTo(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

// A Piece is the model data that the view uses to display a pentomino.
struct Piece {
    let tile: Tile
    var position: Position
    
    static let standard = Piece(tile: Tile.standard, position: Position())
}

// Movable
extension Piece {
    var center: Position {
        Position(x: position.x + tile.width / 2, y: position.y + tile.height / 2)
    }
    
    mutating func moveTo(_ x: Int, _ y: Int) {
        position.moveTo(x, y)
    }
}

