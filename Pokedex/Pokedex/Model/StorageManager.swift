//
//  StorageManager.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import Foundation

class StorageManager {
    static func readFrom<T: Codable>(file: String, into: T.Type) -> T? {
        let mainBundle = Bundle.main
        let url = mainBundle.url(forResource: file, withExtension: "json")
        
        guard url != nil else {
            return nil
        }
        do {
            let data = try Data.init(contentsOf: url!)
            let decoder = JSONDecoder()
            return try decoder.decode(T.self, from: data)
        }
        catch {
            print(error)
            return nil
        }
    }
}
