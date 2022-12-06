//
//  Color+Components.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/20/22.
//

import SwiftUI

extension Color {
    var components: [CGFloat] {
        UIColor(self).cgColor.components!
    }
    
    var darkness: CGFloat {
        let c = components
        return (c[0] + c[1] + c[2]) / 3
    }
    
    init(red: Int16, green: Int16, blue: Int16) {
        self.init(red: Double(red) / 255.0, green: Double(green) / 255.0, blue: Double(blue) / 255.0)
    }
}
