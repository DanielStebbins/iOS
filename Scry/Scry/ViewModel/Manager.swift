//
//  Manager.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import CoreData

class Manager: ObservableObject {
    let container: NSPersistentContainer
    @Published var selectedMap: Map?
    
    init() {
        container = NSPersistentContainer(name: "Bubbles")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        let maps = try! container.viewContext.fetch(NSFetchRequest(entityName: "Map"))
        guard !maps.isEmpty else { return }
        selectedMap = maps[0] as? Map
    }
}
