//
//  Map+Erase.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/8/22.
//

import CoreData

// Deletes user "paint" from the map during erase tool.
extension Map {
    func erase(context: NSManagedObjectContext, x: Double, y: Double, eraseRadius: Double) {
        let circles = drawnCircles!.allObjects as! [DrawnCircle]
        for circle in circles {
            // Delete the circle if the point is within its radius.
            if pow(circle.x - x, 2) + pow(circle.y - y, 2) <= pow(circle.radius + eraseRadius, 2) {
                context.delete(circle)
            }
        }
    }
}

