//
//  StorageManager.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import Foundation

class StorageManager {
    static func readTiles(file: String) -> [Tile] {
        let mainBundle = Bundle.main
        let url = mainBundle.url(forResource: file, withExtension: "json")

        guard url != nil else {
            return []
        }
        do {
            let data = try Data.init(contentsOf: url!)
            let decoder = JSONDecoder()
            return try decoder.decode([Tile].self, from: data)
        }
        catch {
            print(error)
            return []
        }
    }
    
    static func readSolutions(file: String) -> [[String: Position]] {
        let mainBundle = Bundle.main
        let url = mainBundle.url(forResource: file, withExtension: "json")

        guard url != nil else {
            return []
        }
        do {
            let data = try Data.init(contentsOf: url!)
            let decoder = JSONDecoder()
            return try decoder.decode([[String: Position]].self, from: data)
        }
        catch {
            print(error)
            return []
        }
    }
}
