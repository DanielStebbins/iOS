//
//  Color+Random.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

extension Color {
    static var random: Int16 {
        Int16(.random(in: 0.5...1) * 255)
    }
}
