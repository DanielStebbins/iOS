//
//  CapsuleGrid.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/10/22.
//

import SwiftUI

struct CapsuleGrid<T>: View where T: Bubble {
    @ObservedObject var bubble: Bubble
    let title: String
    var bubbles: NSSet
    let addFunction: (T) -> Void
    var shown: Bool = false
    let maxWidth: CGFloat
    
    let padding: CGFloat = 17
    
    var body: some View {
        if shown || bubbles.count != 0 {
            let rows: [[T]] = split()
            
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                    BubbleAdder(bubble: bubble, bubbles: bubbles, addFunction: addFunction)
                }
                ZStack(alignment: .leading)
                {
                    Color.clear
                    VStack(alignment: .leading) {
                        ForEach(Array(rows.enumerated()), id: \.element) { index, element in
                            CapsuleRow(bubble: bubble, bubbles: rows[index])
                        }
                    }
                }
                .padding(7)
                .padding(.top, rows.isEmpty ? 20 : 0)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.white, lineWidth: 2)
                }
            }
            .padding(10)
            .padding(.bottom, 10)
        }
    }
    
    func split() -> [[T]] {
        let bubbleList = bubbles.allObjects as! [T]
        let sortedBubbles = bubbleList.sorted(by: { $0.name! < $1.name! })
        
        var count: CGFloat = 0.0
        var rows: [[T]] = []
        var row: [T] = []
        for bubble in sortedBubbles {
            let textWidth: CGFloat = bubble.name!.size(withAttributes: [.font: UIFont.systemFont(ofSize: 20)]).width
            if count + textWidth + 30 + padding > maxWidth {
                rows.append(row)
                row = []
                count = 0.0
            }
            row.append(bubble)
            count += textWidth + 30 + padding
        }
        if !row.isEmpty {
            rows.append(row)
        }
        return rows
    }
}

struct BubbleAdder<T>: View where T: Bubble {
    @ObservedObject var bubble: Bubble
    var bubbles: NSSet
    let addFunction: (T) -> Void
    
    @State var selection: Bubble?
    @State var selected: Bool = false
    
    var body : some View {
        let excluded: [UUID] = (bubbles.allObjects as! [Bubble]).map({ $0.uuid! })
        NavigationLink(destination: SelectionBubbleList(selection: $selection, selected: $selected, types: [BubbleType.find(type: T.self)], excluded: excluded)
            .onDisappear { bubbleSelected() }){
                Image(systemName: "plus")
                    .imageScale(.large)
            }
    }
    
    func bubbleSelected() {
        if selected {
            addFunction(selection! as! T)
            selected = false
        }
    }
}
