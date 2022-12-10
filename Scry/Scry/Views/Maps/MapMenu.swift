//
//  MapMenu.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct MapMenu: View {
    @ObservedObject var story: Story
    let width: CGFloat
    let close: () -> Void
    @Binding var sheet: ShownSheet?
    
    @Environment(\.managedObjectContext) var context
    
//    @State var searchText: String = ""
    
    var body: some View {
        let maps = story.maps!.allObjects as! [Map]
        let sortedMaps = maps.sorted(by: { $0.name! < $1.name! })
        ScrollView {
            HStack {
                Text("Maps")
                    .font(.headline)
                Spacer()
                Button(action: { sheet = .addMap; close() }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .padding(10)
                }
                .padding(.trailing, -10)
            }
            .padding([.top, .leading, .trailing])
            ForEach(sortedMaps) {map in
//                if searchText == "" || (map.linkedBubble != nil && map.linkedBubble!.name!.contains(searchText)) || (map.linkedBubble == nil && map.name!.contains(searchText)) {
                    MapMenuRow(story: story, map: map, close: close, width: width)
//                }
            }
        }
//        .searchable(text: $searchText, placement: .toolbar)
        .padding([.leading, .trailing])
        .frame(width: width)
        .background(Color.background, ignoresSafeAreaEdges: [])
    }
}

struct MapMenuRow: View {
    @ObservedObject var story: Story
    @ObservedObject var map: Map
    let close: () -> Void
    let width: CGFloat
    
    var body: some View {
        let uiImage = map.image == nil ? UIImage(imageLiteralResourceName: "square-grid") : UIImage(data: map.image!)!
        Button(action: { story.displayedMap = map; close() }) {
            ZStack {
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width * 0.9, height: width * 0.2)
                    .clipped()
                    .cornerRadius(width * 0.06)
                    .overlay {
                        RoundedRectangle(cornerRadius: width * 0.06)
                            .stroke(Color.accentColor, lineWidth: 2)
                    }
                if let linkedBubble = map.linkedBubble {
                    BubbleCapsule(bubble: linkedBubble)
                }
                else {
                    Text(map.name!)
                        .fontWeight(.heavy)
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

