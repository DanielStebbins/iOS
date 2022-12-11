//
//  BubbleEditSheet.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/20/22.
//

import SwiftUI

struct BubbleEditSheet<Content>: View where Content: View {
    @ObservedObject var bubble: Bubble
    let dismissParent: DismissAction
    let content: () -> Content
    
    @Environment (\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        let deleteButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { dismiss(); context.delete(bubble); dismissParent() }) {
                Image(systemName: "trash")
                    .imageScale(.large)
                    .tint(.red)
            }
        }
        
        ClosableView {
            VStack {
                HStack {
                    HStack {
                        Image(systemName: bubble.systemImageName!)
                            .imageScale(.large)
                            .padding(5)
                        TextField("Name", text: Binding($bubble.name)!)
                            .bold()
                            .italic()
                            .font(.headline)
                            .foregroundColor(Color(bubble: bubble).darkness < 0.5 ? .white : .black)
                    }
                    .padding([.leading, .trailing], 7)
                    .padding([.top, .bottom], 5)
                    .background {
                        Capsule()
                            .fill(Color(bubble: bubble))
                    }
                    ColorPicker("", selection: Binding(get: { Color(bubble: bubble) }, set: { _,_ in }), supportsOpacity: false)
                        .labelsHidden()
                }
                .padding(.bottom, 5)
                PhotoPickerView(title: "Choose Image", selection: $bubble.image)
                
                DisplayElementButton(text: "Notes", display: $bubble.displayNotes)
                content()
                Spacer()
            }
            .navigationTitle("Edit Bubble")
            .navigationBarTitleDisplayMode(.inline)
            .padding()
            .toolbar { deleteButton }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            }
        }
    }
}
