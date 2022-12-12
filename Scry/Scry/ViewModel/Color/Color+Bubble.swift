//
//  Color+Bubble.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

extension Color {
    init(bubble: Bubble) {
        self.init(red: bubble.red, green: bubble.green, blue: bubble.blue)
    }
}
