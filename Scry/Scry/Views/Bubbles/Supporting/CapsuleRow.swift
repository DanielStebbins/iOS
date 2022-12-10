//
//  CapsuleRow.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

// T is the type of bubbles in the row, needed for the adding function.
struct CapsuleRow<T>: View where T: Bubble {
    @ObservedObject var bubble: Bubble
    let title: String
    var bubbles: NSSet
    let addFunction: (T) -> Void
    var shown: Bool = false
    
    var body: some View {
        if bubbles.count != 0 || shown {
            let columns = [GridItem(.adaptive(minimum: 100))]
            let bubbleList: [T] = bubbles.allObjects as! [T]
            let sortedBubbles: [T] = bubbleList.sorted(by: { $0.name! < $1.name! })
            
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                    BubbleAdder<T>(bubble: bubble, bubbles: bubbles, addFunction: addFunction)
                }
                ScrollView(.vertical) {
                    LazyVGrid(columns: columns) {
                        ForEach(sortedBubbles) { b in
                            LinkedBubbleCapsule<T>(bubble: b)
                        }
                    }
                }
            }
            .padding()
        }
    }
}

struct BubbleAdder<T>: View {
    @ObservedObject var bubble: Bubble
    var bubbles: NSSet
    let addFunction: (T) -> Void
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var menuBubbles: FetchedResults<Bubble>
    
    var body : some View {
        Menu {
            ForEach(menuBubbles) { b in
                if !b.isEqual(bubble) && !bubbles.contains(b),
                   let typedB = b as? T {
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
