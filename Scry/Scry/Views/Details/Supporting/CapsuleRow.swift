//
//  CapsuleRow.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

struct CapsuleRow<T>: View {
    let title: String
    let bubbles: NSSet
    let addFunction: (T) -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            ScrollView(.horizontal) {
                HStack {
                    ForEach(bubbles.allObjects as! [Bubble]) { bubble in
                        BubbleCapsule(text: bubble.name!, color: Color(bubble: bubble))
                    }
                }
            }
        }
        .padding()
    }
}

struct BubbleAdder<T>: View {
    var bubble: Bubble
    let addFunction: (T) -> Void
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var bubbles: FetchedResults<Bubble>
    
    var body : some View {
        Menu {
            ForEach(bubbles) { b in
                if let typedB = b as? T {
                    Button(action: { addFunction(typedB) }) {
                        Text(b.name!)
                    }
                }
            }
        } label: {
            Image(systemName: "plus")
        }
    }
}
