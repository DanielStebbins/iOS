//
//  Color+Bubble.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

extension Color {
    init(bubble: Bubble) {
        self.init(red: Double(bubble.red) / 255.0, green: Double(bubble.green) / 255.0, blue: Double(bubble.blue) / 255.0)
    }
}
