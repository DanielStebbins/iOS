//
//  GameManager.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import Foundation

class Manager: ObservableObject {
    let tileSize: Int = 40
    var model: Model = Model()
    @Published var board: Int = 0
    
    init() {
        var x: Int = 4
        var y: Int = 11
        for i in 0..<model.pieces.count {
            if(i % 4 == 0) {
                x = 4
                y += 5
            }
            else {
                x += 5
            }
            model.pieces[i].moveTo(x, y)
        }
    }
    
    func boardButtonPress(num: Int) -> () -> Void {
        {
            self.board = num
        }
    }
}
