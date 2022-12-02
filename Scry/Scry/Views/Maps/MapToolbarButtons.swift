//
//  NewBubbleButton.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/2/22.
//

import SwiftUI

struct SelectButton: View {
    @Binding var tool: Tool
    var body: some View {
        Button(action: { tool = .select }) {
            Image(systemName: "cursorarrow")
//                .background(tool == .select ? Color.accentColor : Color.background)
//                .buttonStyle(tool == .select ? .borderedProminent : .)
        }
    }
}

struct NewBubbleButton: View {
    @Binding var tool: Tool
    var body: some View {
        Button(action: { tool = .newBubble }) {
            Image(systemName: "plus.bubble")
//                .background(tool == .newBubble ? Color.accentColor : Color.background)
        }
    }
}

struct LinkBubbleButton: View {
    @Binding var tool: Tool
    var body: some View {
        Button(action: { tool = .linkBubble }) {
            Image(systemName: "link.badge.plus")
//                .background(tool == .linkBubble ? Color.accentColor : Color.background)
        }
    }
}
