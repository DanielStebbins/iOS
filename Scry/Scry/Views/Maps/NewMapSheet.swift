//
//  AddMapSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct NewMapSheet: View {
    var story: Story
    @Binding var showMapMenu: Bool
    
    @Environment(\.managedObjectContext) var context
    @Environment (\.dismiss) private var dismiss
    
    @State var name: String = ""
    @State var image: Data?
    @State var showSheet: Bool = false
    @State var linkedBubble: Bubble?
    
    var body: some View {        
        let submitButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button("Submit") {
                let map = Map(context: context)
                map.name = name
                map.image = image
                story.addToMaps(map)
                story.displayedMap = map
                try? context.save()
                showMapMenu = false
                dismiss()
            }
        }
        
        ClosableView {
            VStack {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("Name", text: $name)
                        .multilineTextAlignment(.trailing)
                        .bold()
                        .italic()
                        .font(.headline)
                }
                .padding([.top, .bottom], 20)
                HStack {
                    Text("Linked Bubble")
                    Spacer()
                    Button(action: { showSheet = true }) {
                        if let bubble = linkedBubble {
                            BubbleCapsule(bubble: bubble)
                        }
                        else {
                            Text("None")
                        }
                    }
                }
                .padding(.bottom, 15)
                PhotoPickerView(title: "Choose Image", selection: $image)
                Spacer()
            }
            .padding([.leading, .trailing], 20)
            .navigationTitle("Create a Map")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showSheet) {
                SelectionBubbleList(selection: $linkedBubble, selected: Binding.constant(false), types: [.location, .faction])
            }
            .toolbar { submitButton }
        }
    }
}
