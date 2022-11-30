//
//  Manager.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import CoreData

class Manager: ObservableObject {
    let container: NSPersistentContainer
    let story: Story
    
    init() {
        container = NSPersistentContainer(name: "Bubbles")
        container.loadPersistentStores { description, error in
            if let error {
                print("Error: \(error.localizedDescription)")
            }
        }
        let fistStoryRequest = NSFetchRequest<Story>(entityName: "Story")
        fistStoryRequest.fetchLimit = 1
        let stories = try! container.viewContext.fetch(fistStoryRequest)
        if stories.isEmpty {
            story = Story(context: container.viewContext)
        }
        else {
            story = stories[0]
        }
    }
    
}
