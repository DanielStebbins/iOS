//
//  Bubble+Validate.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/2/22.
//

import Foundation
import CoreData

extension Bubble {
    override public func validateForDelete() throws {
        try super.validateForDelete()
        guard mappedBubbles!.count == 0 else { throw NSError() }
    }
}
