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
    @Environment(\.managedObjectContext) var context
    @State var showAddMapSheet: Bool = false
    
    var body: some View {
        ScrollView {
            HeaderView(title: "Maps", toggle: $showAddMapSheet)
                .padding()
            ForEach(story.maps!.allObjects as! [Map]) {map in
                Button(action: { story.displayedMap = map }) {
                    Text(map.name!)
                }
                .buttonStyle(.borderedProminent)
            }
        }
        .frame(width: width)
        .background(.gray, ignoresSafeAreaEdges: [])
        .sheet(isPresented: $showAddMapSheet) {
            AddMapSheet(story: story)
        }
    }
}

