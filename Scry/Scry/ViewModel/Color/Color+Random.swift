//
//  Color+Random.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

// Used to give random colors in the new bubble sheet.
extension Color {
    static var randomLightComponent: Int16 {
        Int16(.random(in: Constants.darkColorLimit...1) * 255)
    }
    static var randomDarkComponent: Int16 {
        Int16(.random(in: Constants.lightColorLimit...0.5) * 255)
    }
    static var randomLightColor: Color {
        Color(red: randomLightComponent, green: randomLightComponent, blue: randomLightComponent)
    }
    static var randomDarkColor: Color {
        Color(red: randomDarkComponent, green: randomDarkComponent, blue: randomDarkComponent)
    }
}
