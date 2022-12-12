//
//  Color+Components.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/20/22.
//

import SwiftUI

extension Color {
    // Splits a Color into Components.
    var components: [CGFloat] {
        UIColor(self).cgColor.components!
    }
    
    // Creates a Color from Int16 components (I stored the RGB as Int16 because it's small).
    init(red: Int16, green: Int16, blue: Int16) {
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0)
    }
}
