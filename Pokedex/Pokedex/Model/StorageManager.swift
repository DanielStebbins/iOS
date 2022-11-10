//
//  StorageManager.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import Foundation

class StorageManager<T:Codable> {
    var modelData: T?
    let filename: String
    let fileInfo: FileInfo
    init(name: String) {
        filename = name
        fileInfo = FileInfo(for: filename)
        
        // On subsequent runs.
        if fileInfo.exists {
            let decoder = JSONDecoder()
            do {
                let data = try Data(contentsOf: fileInfo.url)
                modelData = try decoder.decode(T.self, from: data)
            } catch {
                print(error)
                modelData = nil
            }
            return
        }
        
        // On the first run.
        let mainBundle = Bundle.main
        let url = mainBundle.url(forResource: filename, withExtension: "json")
        guard url != nil else {
            modelData = nil
            return
        }
        do {
            let data = try Data.init(contentsOf: url!)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            modelData = try decoder.decode(T.self, from: data)
        }
        catch {
            print(error)
            modelData = nil
        }
    }
    
    func save(_ modelData: T) {
        do {
            let encoder = JSONEncoder()
            let datajson = try encoder.encode(modelData)
            try datajson.write(to: fileInfo.url)
        }
        catch {
            print(error)
        }
    }
}

struct FileInfo {
    let name: String
    let url: URL
    let exists: Bool
    
    init(for filename: String) {
        name = filename
        let fileManager = FileManager.default
        let documentURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        url =  documentURL.appendingPathComponent(filename + ".json")
        exists = fileManager.fileExists(atPath: url.path)
    }
    
    private init(name:String, url:URL, exists:Bool) {
        self.init(for:"")
    }
}

//class StorageManager {
//    static func readFrom<T: Codable>(file: String, into: T.Type) -> T? {
//        let mainBundle = Bundle.main
//        let url = mainBundle.url(forResource: file, withExtension: "json")
//
//        guard url != nil else {
//            return nil
//        }
//        do {
//            let data = try Data.init(contentsOf: url!)
//            let decoder = JSONDecoder()
//            decoder.keyDecodingStrategy = .convertFromSnakeCase
//            return try decoder.decode(T.self, from: data)
//        }
//        catch {
//            print(error)
//            return nil
//        }
//    }
//}
