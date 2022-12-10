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
    }
}

extension Character {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "person")
    }
}

extension Faction {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "flag")
    }
}

extension Item {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "wand.and.stars")
    }
}

extension Location {
    convenience init(context: NSManagedObjectContext, name: String, color: Color, image: Data?) {
        self.init(context: context)
        self.setup(name: name, color: color, image: image, systemImageName: "location")
    }
}
