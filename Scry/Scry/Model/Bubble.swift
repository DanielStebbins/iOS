//
//  Bubble.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import Foundation

// Taboo?
import SwiftUI

class Bubble: Identifiable {
    var title: String
    var color: Color
    
    var description: String?
    var notes: String?
    var memberOf: [Bubble]?
    var members: [Bubble]?
    var allies: [Bubble]?
    var enemies: [Bubble]?
    
    init() {
        title = ""
        color = .random
    }
    
    init(title: String) {
        self.title = title
        color = .random
    }
    
    init(title: String, color: Color, description: String? = nil, notes: String? = nil, members: [Bubble]? = nil) {
        self.title = title
        self.color = color
        self.description = description
        self.notes = notes
        self.members = members
    }
}
