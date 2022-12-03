//
//  Color+Random.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

extension Color {
    static var randomLightComponent: Int16 {
        Int16(.random(in: 0.5...1) * 255)
    }
    static var randomDarkComponent: Int16 {
        Int16(.random(in: 0...0.5) * 255)
    }
    static var randomLightColor: Color {
        Color(red: randomLightComponent, green: randomLightComponent, blue: randomLightComponent)
    }
    static var randomDarkColor: Color {
        Color(red: randomDarkComponent, green: randomDarkComponent, blue: randomDarkComponent)
    }
}
