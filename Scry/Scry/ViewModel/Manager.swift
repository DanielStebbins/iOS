//
//  Manager.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import Foundation
import SwiftUI

class Manager: ObservableObject {
    @Published var bubbles: [Bubble]
    
    init() {
        bubbles = [Bubble(title: "Test", color: .cyan, description: "Super Duper Test", notes: "Probably has a tragic backstory", members: [Bubble(title: "Test Member 1"), Bubble(title: "Test Member 2")])]
    }
}
