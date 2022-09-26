//
//  GameManager.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import Foundation

class Manager: ObservableObject {
    let tileSize: Double = 40.0
    let boardXOffset: Double = 28.0;
    @Published var model: Model = Model()
    @Published var board: Int = 0
    
    // Button Disablers.
    var resetButtonDisabled: Bool = true
    var solveButtonDisabled: Bool {
        board == 0
    }
    
    init() {
        resetPieces()
    }
    
    func resetPieces() {
        var x: Double = 5
        var y: Double = 11
        for i in 0..<model.pieces.count {
            if(i % 4 == 0) {
                x = 5
                y += 5
            }
            else {
                x += 5
            }
//            model.pieces[i].moveTo(x, y)
//            model.pieces[i].position.isFlipped = false
//            model.pieces[i].position.rotations = 0;
            model.pieces[i].position = Position(x, y)
        }
        resetButtonDisabled = true
    }
    
    // Button Press Functions.
    func boardButtonPress(num: Int) -> () -> Void {
        {
            self.board = num
        }
    }
    
    func resetButtonPress() {
        resetPieces()
    }
    
    func solveButtonPress() {
        
    }
}
