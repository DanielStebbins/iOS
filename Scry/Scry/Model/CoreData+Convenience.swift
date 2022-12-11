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
    
    func relationshipColor(bubble: Bubble) -> Color {
        if self.factions!.contains(bubble) || self.items!.contains(bubble) || self.locations!.contains(bubble) {
            return Color.blue
        }
        else {
            return Color.clear
        }
    }
}

extension Faction {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "flag")
    }
    
    func relationshipColor(bubble: Bubble) -> Color {
        if self.subfactions!.contains(bubble) || self.members!.contains(bubble) || self.items!.contains(bubble) || self.locations!.contains(bubble) {
            return Color.red
        }
        else if self.superfactions!.contains(bubble) {
            return Color.orange
        }
        else {
            return Color.clear
        }
    }
}

extension Item {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "wand.and.stars")
    }
    
    func relationshipColor(bubble: Bubble) -> Color {
        if self.factions!.contains(bubble) || self.characters!.contains(bubble) || self.locations!.contains(bubble) {
            return Color.purple
        }
        else {
            return Color.clear
        }
    }
}

extension Location {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "location")
    }
    
    func relationshipColor(bubble: Bubble) -> Color {
        if self.factions!.contains(bubble) || self.characters!.contains(bubble) || self.items!.contains(bubble) {
            return Color.green
        }
        else {
            return Color.clear
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
