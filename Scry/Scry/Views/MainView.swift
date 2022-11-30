//
//  MapContainer.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var story: Story
    
    @Environment(\.managedObjectContext) var context
    @State var showMapMenu: Bool = false
    @State var sheet: ShownSheet?
    @State var newDisplayedMap: Bool = false
    
    var body: some View {
        let menuButton = ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { withAnimation { showMapMenu.toggle() } }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
            }
        }
        
        let optionsButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { withAnimation { sheet = .options } }) {
                Image(systemName: "gearshape")
                    .imageScale(.large)
            }
            .disabled(story.displayedMap == nil)
        }
        
        let bubbleListButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { withAnimation { sheet = .bubbleList } }) {
                Image(systemName: "list.bullet")
                    .imageScale(.large)
            }
            .disabled(story.displayedMap == nil)
        }
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -30 {
                    withAnimation {
                        self.showMapMenu = false
                    }
                }
            }
        
        GeometryReader { geometry in
            NavigationStack {
                ZStack(alignment: .leading) {
                    if story.displayedMap != nil {
                        ScrollingMapView(map: story.displayedMap!)
                            .disabled(showMapMenu)
                    }
                    else {
                        Text("Use the menu at the upper left to add a map!")
                            .navigationTitle("Add a Map")
                            .navigationBarTitleDisplayMode(.inline)
                    }
                    if showMapMenu {
                        MapMenu(story: story, width: geometry.size.width * 0.8, shown: $showMapMenu)
                            .transition(.move(edge: .leading))
                            .gesture(drag)
                            .zIndex(1)
                    }
                }
                .background(Color.background)
                .sheet(item: $sheet, onDismiss: { sheetDismiss() }) {item in
                    switch item {
                    case .options: OptionsSheet(map: story.displayedMap!, newMap: $newDisplayedMap)
                    case .bubbleList: BubbleList()
                    }
                }
                .toolbar { menuButton }
                .toolbar { optionsButton }
                .toolbar { bubbleListButton }
            }
        }
    }
    
    func sheetDismiss() {
        if newDisplayedMap {
            let array = story.maps!.allObjects as! [Map]
            story.displayedMap = array.min(by: { $0.name! < $1.name! })
            newDisplayedMap = false
            try? context.save()
        }
    }
}

enum ShownSheet: String, Identifiable {
    case options
    case bubbleList
    var id: RawValue { rawValue }
}
