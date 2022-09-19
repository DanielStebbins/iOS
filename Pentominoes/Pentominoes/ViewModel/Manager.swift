//
//  GameManager.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import Foundation

class Manager: ObservableObject {
    @Published var board: Int = 0
    
    func boardButtonPress(num: Int) -> () -> Void {
        {
            self.board = num
        }
    }
    
    func toBoardImage(num: Int) -> String {
        "Board\(num)"
    }
    
    func toButtonImage(num: Int) -> String {
        "Board\(num)button"
    }
}
