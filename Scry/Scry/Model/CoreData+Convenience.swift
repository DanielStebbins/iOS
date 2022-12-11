//
//  Character+Convenience.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/9/22.
//

import CoreData
import SwiftUI

extension Bubble {
    func setup(name: String, color: Color, image: Data?, systemImageName: String) {
        self.name = name
        let components = color.components
        red = Int16(components[0] * 255)
        green = Int16(components[1] * 255)
        blue = Int16(components[2] * 255)
        self.image = image
        self.systemImageName = systemImageName
        self.uuid = UUID()
    }
}

extension Character {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "person")
    }
    
    func relationshipColor(bubble: Bubble?) -> Color {
        if let bubble, self.factions!.contains(bubble) || self.items!.contains(bubble) || self.locations!.contains(bubble) {
            return Color.blue
        }
        else {
            return Color.clear
        }
    }
    
    func toggleRelationship(bubble: Bubble) {
        switch bubble {
        case _ as Character: return
        case let faction as Faction: self.factions!.contains(faction) ? self.removeFromFactions(faction) : self.addToFactions(faction)
        case let item as Item: self.items!.contains(item) ? self.removeFromItems(item) : self.addToItems(item)
        case let location as Location: self.locations!.contains(location) ? self.removeFromLocations(location) : self.addToLocations(location)
        default: return
        }
    }
}

extension Faction {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "flag")
    }
    
    func relationshipColor(bubble: Bubble?) -> Color {
        if let bubble, self.subfactions!.contains(bubble) || self.members!.contains(bubble) || self.items!.contains(bubble) || self.locations!.contains(bubble) {
            return Color.red
        }
        else if let bubble, self.superfactions!.contains(bubble) {
            return Color.orange
        }
        else {
            return Color.clear
        }
    }
    
    func toggleRelationship(bubble: Bubble) {
        switch bubble {
        case let character as Character: self.members!.contains(character) ? self.removeFromMembers(character) : self.addToMembers(character)
        case _ as Faction: return
        case let item as Item: self.items!.contains(item) ? self.removeFromItems(item) : self.addToItems(item)
        case let location as Location: self.locations!.contains(location) ? self.removeFromLocations(location) : self.addToLocations(location)
        default: return
        }
    }
}

extension Item {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "wand.and.stars")
    }
    
    func relationshipColor(bubble: Bubble?) -> Color {
        if let bubble, self.factions!.contains(bubble) || self.characters!.contains(bubble) || self.locations!.contains(bubble) {
            return Color.purple
        }
        else {
            return Color.clear
        }
    }
    
    func toggleRelationship(bubble: Bubble) {
        switch bubble {
        case let character as Character: self.characters!.contains(character) ? self.removeFromCharacters(character) : self.addToCharacters(character)
        case let faction as Faction: self.factions!.contains(faction) ? self.removeFromFactions(faction) : self.addToFactions(faction)
        case _ as Item: return
        case let location as Location: self.locations!.contains(location) ? self.removeFromLocations(location) : self.addToLocations(location)
        default: return
        }
    }
}

extension Location {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "location")
    }
    
    func relationshipColor(bubble: Bubble?) -> Color {
        if let bubble, self.factions!.contains(bubble) || self.characters!.contains(bubble) || self.items!.contains(bubble) {
            return Color.green
        }
        else {
            return Color.clear
        }
    }
    
    func toggleRelationship(bubble: Bubble) {
        switch bubble {
        case let character as Character: self.characters!.contains(character) ? self.removeFromCharacters(character) : self.addToCharacters(character)
        case let faction as Faction: self.factions!.contains(faction) ? self.removeFromFactions(faction) : self.addToFactions(faction)
        case let item as Item: self.items!.contains(item) ? self.removeFromItems(item) : self.addToItems(item)
        case _ as Location: return
        default: return
        }
    }
}

extension MappedBubble {
    convenience init(context: NSManagedObjectContext, bubble: Bubble, x: Double, y: Double) {
        self.init(context: context)
        self.bubble = bubble
        self.x = x
        self.y = y
        self.lastChanged = Date.now
    }
}
