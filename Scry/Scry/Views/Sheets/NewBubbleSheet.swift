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
    var types: [BubbleType] = [.character, .faction, .item, .location]
    
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
                InputCapsule(name: $name, color: $color, image: $image, bubbleType: $bubbleType, types: types)
                PhotoPickerView(title: "Bubble Image", selection: $image)
                Spacer()
            }
            .navigationTitle("Create a \(types.count == 1 ? types[0].rawValue : "Bubble")")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { submitButton }
            .padding([.leading, .trailing])
            .onAppear() {
                bubbleType = types.count == 1 ? types[0] : .character
            }
        }
    }
}

struct InputCapsule: View {
    @Binding var name: String
    @Binding var color: Color
    @Binding var image: Data?
    @Binding var bubbleType: BubbleType
    let types: [BubbleType]
    
    var body: some View {
        HStack {
            HStack {
                TypePicker(types: types, selection: $bubbleType)
                    .tint(.white)
                TextField("Name", text: $name)
                    .bold()
                    .italic()
                    .font(.headline)
                    .foregroundColor(.white)
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
        .padding(.bottom, 5)
    }
}

struct TypePicker: View {
    let types: [BubbleType]
    @Binding var selection: BubbleType
    
    var body: some View {
        if types.count == 1 {
            Image(systemName: types[0].imageName)
                .imageScale(.large)
                .padding(5)
        }
        else {
            Picker("Bubble Type", selection: $selection) {
                ForEach(types) {
                    Label($0.rawValue, systemImage: $0.imageName).tag($0)
                        .labelStyle(.iconOnly)
                }
            }
            .pickerStyle(.menu)
        }
    }
}
