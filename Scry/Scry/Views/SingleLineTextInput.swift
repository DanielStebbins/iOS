//
//  SingleLineTextInput.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/16/22.
//

import SwiftUI

struct SingleLineTextInput: View {
    @EnvironmentObject var manager: Manager
    @Environment(\.managedObjectContext) var context
    
    @Binding var isEditing: Bool
    var template: String
    var adding: (String) -> Void
    
    @State var text : String = ""
    var body: some View {
        if isEditing {
            TextField(template, text: $text)
                .onSubmit {
                    adding(text)
                    isEditing = false
                    text = ""
                    try? context.save()
                }
        } else {
            EmptyView()
        }
    }
}

