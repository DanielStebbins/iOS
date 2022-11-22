//
//  CapsuleRow.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

// T is the type of bubbles in the row, needed for the adding function.
struct CapsuleRow<T>: View {
    @ObservedObject var bubble: Bubble
    let title: String
    var bubbles: NSSet
    let addFunction: (T) -> Void
    
//    private let columns = [GridItem(.adaptive(minimum: 70))]
    private let columns = [GridItem(.flexible(minimum: 30)), GridItem(.flexible(minimum: 30)), GridItem(.flexible(minimum: 30))]
    
    var bubbleList: [Bubble] { bubbles.allObjects as! [Bubble] }
    var sortedBubbles: [Bubble] { bubbleList.sorted(by: { $0.name! < $1.name! }) }
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                BubbleAdder<T>(bubble: bubble, bubbles: bubbles, addFunction: addFunction)
            }
            ScrollView(.vertical) {
                LazyVGrid(columns: columns) {
                    ForEach(sortedBubbles) { bubble in
                        BubbleCapsule(bubble: bubble)
                    }
                }
            }
        }
        .padding()
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
