//
//  AddBubbleSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/30/22.
//

import SwiftUI

struct AddBubbleSheet: View {
    let map: Map
    let x: Double
    let y: Double
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context
    @Environment (\.dismiss) private var dismiss
    
    @State var bubbleType: BubbleType = .character
    @State var name: String = ""
    @State var color: Color = Color.randomDarkColor
    
    var body: some View {
        VStack {
            Picker("Bubble Type", selection: $bubbleType) {
                ForEach(BubbleType.allCases) {
                    Text(String($0.rawValue)).tag($0)
                }
            } .pickerStyle(.segmented)
            TextField("Name", text: $name)
                .multilineTextAlignment(.center)
                .bold()
                .italic()
                .font(.headline)
                .padding([.leading, .trailing], 7)
                .padding([.top, .bottom], 5)
                .background {
                    Capsule()
                        .fill(color)
                }
            ColorPicker("Choose Color", selection: $color)
            Button("Submit") {
                var bubble: Bubble
                switch(bubbleType) {
                case .character: bubble = Character(context: context)
                case .faction: bubble = Faction(context: context)
                case .item: bubble = Item(context: context)
                case .location: bubble = Location(context: context)
                }
                
                bubble.name = name
                let components = color.components
                bubble.red = Int16(components.red * 255)
                bubble.green = Int16(components.green * 255)
                bubble.blue = Int16(components.blue * 255)
                
                let mappedBubble = MappedBubble(context: context)
                mappedBubble.bubble = bubble
                mappedBubble.x = x
                mappedBubble.y = y
                map.addToMappedBubbles(mappedBubble)
                
                try? context.save()
                dismiss()
            }
        }
    }
}

enum BubbleType: String, Identifiable, CaseIterable {
    case character, faction, item, location
    var id: RawValue { rawValue }
}

