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
                TextField("Name", text: $name)
                    .multilineTextAlignment(.center)
                    .bold()
                    .italic()
                    .font(.headline)
                    .padding([.leading, .trailing], 7)
                    .padding([.top, .bottom], 5)
                    .background {
                        Capsule()
                            .fill(Color.accentColor)
                    }
                    .padding([.leading, .trailing, .top])
                PhotoPickerView(title: "Map Image", selection: $image)
                    .padding([.leading, .trailing, .bottom])
            }
            .navigationTitle("Create a Map")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { submitButton }
        }
    }
}
