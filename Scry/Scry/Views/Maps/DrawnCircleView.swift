//
//  DrawnCircleView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/8/22.
//

import SwiftUI

struct DrawnCircleView: View {
    @ObservedObject var circle: DrawnCircle
    var body: some View {
        Circle()
            .fill(Color(red: circle.red, green: circle.green, blue: circle.blue))
            .opacity(circle.opacity)
            .frame(width: circle.radius * 2, height: circle.radius * 2)
            .position(x: circle.x, y: circle.y)
    }
}
