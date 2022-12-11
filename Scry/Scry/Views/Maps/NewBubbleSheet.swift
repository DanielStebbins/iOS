//
//  AddBubbleSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/30/22.
//

import SwiftUI

struct NewBubbleSheet: View {
    @Binding var selectedBubble: Bubble?
    @Binding var added: Bool
    
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) var context
    @Environment (\.dismiss) private var dismiss
    
    @State var bubbleType: BubbleType = .character
    @State var name: String = ""
    @State var color: Color = Color.randomDarkColor
    @State var image: Data?
    
    var body: some View {
        let submitButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button("Submit") {
                var bubble: Bubble
                switch(bubbleType) {
                case .character: bubble = Character(context: context, name: name, color: color, image: image)
                case .faction: bubble = Faction(context: context, name: name, color: color, image: image)
                case .item: bubble = Item(context: context, name: name, color: color, image: image)
                case .location: bubble = Location(context: context, name: name, color: color, image: image)
                }
                selectedBubble = bubble
                added = true
                
                try? context.save()
                dismiss()
            }
        }
        
        ClosableView {
            VStack {
                HStack {
                    HStack {
                        Picker("Bubble Type", selection: $bubbleType) {
                            ForEach(BubbleType.allCases) {
                                Label($0.rawValue, systemImage: $0.imageName).tag($0)
                                    .labelStyle(.iconOnly)
                            }
                        }
                        .tint(.white)
                        .pickerStyle(.menu)
                        TextField("Name", text: $name)
                            .bold()
                            .italic()
                            .font(.headline)
                            .foregroundColor(color.darkness < 0.5 ? .white : .black)
                    }
                    .padding([.leading, .trailing], 7)
                    .padding([.top, .bottom], 5)
                    .background {
                        Capsule()
                            .fill(color)
                    }
                    ColorPicker("", selection: $color, supportsOpacity: false)
                        .labelsHidden()
                }
                .padding(.bottom)
                PhotoPickerView(title: "Bubble Image", selection: $image)
                Spacer()
            }
            .navigationTitle("Create a Bubble")
            .navigationBarTitleDisplayMode(.inline)
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
