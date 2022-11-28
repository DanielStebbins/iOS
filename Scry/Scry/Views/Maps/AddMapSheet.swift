//
//  AddMapSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct AddMapSheet: View {
    @Environment(\.managedObjectContext) var context
    @Environment (\.dismiss) private var dismiss
    @State var name: String = ""
    @State var image: Data?
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: $name)
                    .multilineTextAlignment(.center)
                    .bold()
                    .italic()
                    .font(.headline)
                PhotoPickerView(selection: $image)
                Button("Submit") {
                    let map = Map(context: context)
                    map.name = name
                    map.image = image
                    dismiss()
                }
            }
            .toolbar { DismissButton(dismiss: dismiss).toolbarItem }
        }
    }
}
