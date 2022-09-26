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
// Changed to use Double coordinates to adjust by 0.5 depending on whether the number of tiles is even or odd.
struct Position: Codable {
    var x: Double
    var y: Double
    var isFlipped : Bool
    var rotations : Int
    
    init() {
        x = 0.0
        y = 0.0
        isFlipped = false
        rotations = 0
    }
}

// More x,y control.
extension Position {
    init(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
        isFlipped = false
        rotations = 0
    }
    
    mutating func moveTo(_ x: Double, _ y: Double) {
        self.x = x
        self.y = y
    }
    
    mutating func moveBy(_ x: Double, _ y: Double) {
        self.x += x
        self.y += y
    }
}


// A Piece is the model data that the view uses to display a pentomino.
struct Piece: Identifiable {
    let tile: Tile
    var position: Position
    var id = UUID()
    
    static let standard = Piece(tile: Tile.standard, position: Position())
}

// Movable
extension Piece {
    var currentWidth: Int { position.rotations % 2 == 0 ? tile.width : tile.height }
    var currentHeight: Int { position.rotations % 2 == 0 ? tile.height : tile.width }
    
    var center: Position {
        Position(position.x + Double(currentWidth) / 2 - 0.5, position.y + Double(currentHeight) / 2 - 0.5)
    }
    
    mutating func moveTo(_ x: Double, _ y: Double) {
        position.moveTo(x, y)
    }
    
    mutating func moveBy(_ x: Double, _ y: Double) {
        position.moveBy(x, y)
    }
}

