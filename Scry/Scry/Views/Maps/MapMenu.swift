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
                MapMenuRow(story: story, map: map, shown: $shown, width: width)
            }
        }
        .frame(width: width)
        .background(Color.background, ignoresSafeAreaEdges: [])
        .sheet(isPresented: $showAddMapSheet) {
            AddMapSheet(story: story, showMapMenu: $shown)
        }
    }
}

struct MapMenuRow: View {
    @ObservedObject var story: Story
    @ObservedObject var map: Map
    @Binding var shown: Bool
    var width: CGFloat
    
    var body: some View {
        let uiImage = map.image == nil ? UIImage(imageLiteralResourceName: "square-grid") : UIImage(data: map.image!)!
        Button(action: { story.displayedMap = map; withAnimation { shown = false } }) {
            ZStack {
                RoundedRectangle(cornerRadius: width * 0.06)
                    .fill(Color.accentColor)
                    .frame(width: width * 0.9, height: width * 0.2)
                Image(uiImage: uiImage)
                    .resizable()
                    .scaledToFill()
                    .frame(width: width * 0.9 - 4, height: width * 0.2 - 4)
                    .clipped()
                    .cornerRadius(width * 0.06)
                Text(map.name!)
                    .fontWeight(.heavy)
                    .foregroundColor(.accentColor)
            }
            .padding([.leading, .trailing])
        }
    }
}

