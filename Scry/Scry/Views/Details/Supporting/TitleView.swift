//
//  TitleView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI
import CoreData

struct TitleView: View {
    let bubble: Bubble
    
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var context
    
    var body: some View {
        HStack {
            Spacer()
            BubbleCapsule(text: bubble.name!, color: Color(bubble: bubble), font: .title)
            Spacer()
            Button(role: .destructive,
                   action: {
                //TODO: delete action here
                context.delete(bubble)
                dismiss()
            },
                   label: {Image(systemName: "trash").imageScale(.large)})
        }.padding()
    }
}
