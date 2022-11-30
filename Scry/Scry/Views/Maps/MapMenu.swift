//
//  MapMenu.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct MapMenu: View {
    @ObservedObject var story: Story
    var width: CGFloat
    @Binding var shown: Bool
    
    @Environment(\.managedObjectContext) var context
    @State var showAddMapSheet: Bool = false
    
    var body: some View {
        let maps = story.maps!.allObjects as! [Map]
        let sortedMaps = maps.sorted(by: { $0.name! < $1.name! })
        
        ScrollView {
            HeaderView(title: "Maps", toggle: $showAddMapSheet)
                .padding()
            ForEach(sortedMaps) {map in
                Button(action: { withAnimation { shown = false }; story.displayedMap = map }) {
                    Text(map.name!)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(width: width)
        .background(.gray, ignoresSafeAreaEdges: [])
        .sheet(isPresented: $showAddMapSheet) {
            AddMapSheet(story: story, showMapMenu: $shown)
        }
    }
}

