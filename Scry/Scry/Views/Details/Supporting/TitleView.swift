//
//  TitleView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI
import CoreData

struct TitleView: View {
    @ObservedObject var bubble: Bubble
    @Binding var isEditing: Bool
    
    @FocusState var titleEdit
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        HStack {
            Spacer()
            BubbleCapsule(bubble: bubble, font: .headline)
            Spacer()
            Button(action:{
                isEditing.toggle()
                titleEdit = true
            }) {
                Image(systemName: "pencil").imageScale(.large)
            }
        }
    }
}
