//
//  AddBubbleSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/30/22.
//

import SwiftUI

struct AddBubbleSheet: View {
    let map: Map
    
    // These are bindings to avoid the "sheet variables not getting assigned a value" bug.
    @Binding var x: Double
    @Binding var y: Double
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context
    @Environment (\.dismiss) private var dismiss
    
    @State var bubbleType: BubbleType = .character
    @State var name: String = ""
    @State var color: Color = Color.randomDarkColor
    @State var image: Data?
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarLeading) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        
        let submitButton = ToolbarItem(placement: .navigationBarTrailing) {
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
                bubble.image = image
                bubble.systemImageName = bubbleType.imageName
                
                let mappedBubble = MappedBubble(context: context)
                mappedBubble.bubble = bubble
                mappedBubble.x = x
                mappedBubble.y = y
                map.addToMappedBubbles(mappedBubble)
                
                try? context.save()
                dismiss()
            }
        }
        
        NavigationStack {
            VStack {
                HStack {
                    Picker("Bubble Type", selection: $bubbleType) {
                        ForEach(BubbleType.allCases) {
                            Label($0.rawValue, systemImage: $0.imageName).tag($0)
                                .labelStyle(.iconOnly)
                        }
                    }
                    .pickerStyle(.menu)
                    TextField("Name", text: $name)
                        .bold()
                        .italic()
                        .font(.headline)
                }
                    .padding([.leading, .trailing], 7)
                    .padding([.top, .bottom], 5)
                    .background {
                        Capsule()
                            .fill(color)
                    }
                    .padding(.bottom)
                ColorPicker("Choose Color", selection: $color, supportsOpacity: false)
                PhotoPickerView(selection: $image)
                Spacer()
            }
            .navigationTitle("Create a Bubble")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { dismissButton }
            .toolbar { submitButton }
            .padding([.leading, .trailing])
        }
    }
}

enum BubbleType: String, Identifiable, CaseIterable {
    case character = "Character", faction = "Faction", item = "Item", location = "Location"
    var id: RawValue { rawValue }
    var imageName: String {
        switch self {
        case .character: return "person"
        case .faction: return "flag"
        case .item: return "wand.and.stars"
        case .location: return "location"
        }
    }
}

