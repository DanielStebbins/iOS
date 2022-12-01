//
//  AddMapSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct AddMapSheet: View {
    var story: Story
    @Binding var showMapMenu: Bool
    
    @Environment(\.managedObjectContext) var context
    @Environment (\.dismiss) private var dismiss
    
    @State var name: String = ""
    @State var image: Data?
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        
        NavigationStack {
            VStack {
                TextField("Name", text: $name)
                    .multilineTextAlignment(.center)
                    .bold()
                    .italic()
                    .font(.headline)
                PhotoPickerView(selection: $image)
                    .padding()
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
            .toolbar { dismissButton }
        }
    }
}
