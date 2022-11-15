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
//        bubbles = [Bubble(title: "Test", color: .cyan, description: "Super Duper Test", notes: "Probably has a tragic backstory", members: [Bubble(title: "Test Member 1"), Bubble(title: "Test Member 2")])]
    }
}
