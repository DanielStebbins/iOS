//
//  Color+Random.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

extension Color {
    static var random: Color {
        Color(red: .random(in: 0.5...1), green: .random(in: 0.5...1), blue: .random(in: 0.5...1))
    }
}
