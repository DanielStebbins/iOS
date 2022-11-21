//
//  Manager.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import CoreData

class Manager: ObservableObject {
    let container : NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "Bubbles")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
}