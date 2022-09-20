//
//  GameManager.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import Foundation

class Manager: ObservableObject {
    let model: Model = Model()
    @Published var board: Int = 0
    
    var boardImage: String {
        "Board\(board)"
    }
    
    func boardButtonPress(num: Int) -> () -> Void {
        {
            self.board = num
            print(self.model.tiles)
        }
    }
    
    func toButtonImage(num: Int) -> String {
        "Board\(num)button"
    }
}
