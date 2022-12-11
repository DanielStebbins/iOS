//
//  OptionsSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct OptionsSheet: View {
    @ObservedObject var map: Map
    @Binding var newMap: Bool
    
    @EnvironmentObject var manager: Manager
    @Environment(\.managedObjectContext) var context
    @Environment (\.dismiss) private var dismiss
    
    @State var showSheet: Bool = false
    
    var body: some View {
        let deleteButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button(role: .destructive, action: { dismiss(); context.delete(map); newMap = true }) {
                Image(systemName: "trash")
                    .imageScale(.large)
                    .foregroundColor(.red)
            }
        }
        
        ClosableView {
            VStack {
                HStack {
                    Text("Name")
                    Spacer()
                    TextField("Name", text: Binding($map.name)!)
                        .multilineTextAlignment(.trailing)
                        .bold()
                        .italic()
                        .font(.headline)
                }
                PhotoPickerView(title: "Map Image", selection: $map.image)
                HStack {
                    Text("Linked Bubble")
                    Spacer()
                    Button(action: { showSheet = true }) {
                        if let bubble = map.linkedBubble {
                            BubbleCapsule(bubble: bubble)
                        }
                        else {
                            Text("None")
                        }
                    }
                }
                .navigationTitle("Map Options")
                .navigationBarTitleDisplayMode(.inline)
            }
            .padding()
            .sheet(isPresented: $showSheet) {
                SelectionBubbleList(selection: $map.linkedBubble, selected: Binding.constant(false), types: [.location, .faction])
            }
            .toolbar { deleteButton}
        }
    }
}
