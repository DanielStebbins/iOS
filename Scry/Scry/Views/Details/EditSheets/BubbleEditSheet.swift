//
//  BubbleEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/20/22.
//

import SwiftUI

struct BubbleEditSheet: View {
    @ObservedObject var bubble: Bubble
    
    var body: some View {
        TextField("Name", text: Binding($bubble.name)!)
            .multilineTextAlignment(.center)
            .bold()
            .italic()
            .font(.headline)
            .padding([.leading, .trailing], 7)
            .padding([.top, .bottom], 5)
            .background {
                Capsule()
                    .fill(Color(bubble: bubble))
            }
        ColorPicker("Choose Color", selection: Binding(get: { Color(bubble: bubble) }, set: {newColor in
            let components = newColor.components
            bubble.red = Int16(components.red * 255)
            bubble.green = Int16(components.green * 255)
            bubble.blue = Int16(components.blue * 255)
        }), supportsOpacity: false)
        PhotoPickerView(selection: $bubble.image)
        
        DisplayElementButton(text: "Image", display: $bubble.displayImage)
        DisplayElementButton(text: "Notes", display: $bubble.displayNotes)
    }
}

