//
//  BubbleEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/20/22.
//

import SwiftUI

// ViewBuilder that handles the dismiss button, delete button, name, color, image, and show notes button.
struct BubbleEditSheet<Content>: View where Content: View {
    @ObservedObject var bubble: Bubble
    let dismissParent: DismissAction
    let content: () -> Content
    
    @Environment (\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        // Has to dismiss this view and the parent view (bubble details), or else the deletion causes bugs.
        let deleteButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { dismiss(); context.delete(bubble); dismissParent() }) {
                Image(systemName: "trash")
                    .imageScale(.large)
                    .tint(.red)
            }
        }
        
        let type = BubbleType(bubble: bubble)
        ClosableView {
            VStack {
                // Uses the same input capsule design as the new button sheet.
                InputCapsule(name: Binding($bubble.name)!, color: Binding(get: { Color(bubble: bubble) }, set: { bubble.changeColor(color: $0) }), image: $bubble.image, bubbleType: Binding.constant(type), types: [type])
                    .padding(.bottom, 5)
                PhotoPickerView(title: "Choose Image", selection: $bubble.image)
                DisplayElementButton(text: "Notes", display: $bubble.displayNotes)
                content()
                Spacer()
            }
            .padding()
            .navigationTitle("Edit \(type.rawValue)")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { deleteButton }
        }
    }
}
