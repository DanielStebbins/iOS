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
    @Environment(\.dismissSearch) private var dismissSearch
    
    @State var showMapMenu: Bool = false
    @State var mapMenuPosition: CGFloat = 0.0
    @State var sheet: ShownSheet?
    @State var newDisplayedMap: Bool = false
    
    var body: some View {
        let menuButton = ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { mapMenuButtonAction() }) {
                Image(systemName: "line.horizontal.3")
                    .imageScale(.large)
                    .padding([.top, .bottom, .trailing])
            }
        }
        
        let optionsButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { closeMapMenu(); sheet = .options  }) {
                Image(systemName: "gearshape")
                    .imageScale(.large)
            }
            .disabled(story.displayedMap == nil)
        }

        let bubbleListButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: { closeMapMenu(); sheet = .bubbleList }) {
                Image(systemName: "list.bullet")
                    .imageScale(.large)
            }
            .disabled(story.displayedMap == nil)
        }
        

        let drag = DragGesture()
            .onChanged { value in
                mapMenuPosition = min(0, value.translation.width)
            }
            .onEnded {
                if $0.translation.width < -50 {
                    closeMapMenu()
                }
                else {
                    withAnimation(.linear(duration: 0.25)) { self.mapMenuPosition = 0.0 }
                }
            }
        
        GeometryReader { geometry in
            NavigationStack {
                ZStack(alignment: .leading) {
                    ZStack(alignment: .center) {
                        if story.displayedMap != nil {
                            ScrollingMapView(map: story.displayedMap!, showMapMenu: $showMapMenu)
                        }
                        else {
                            Color.mapBackground
                            Text("Use the menu at the upper left to add a map!")
                                .onTapGesture { showMapMenu = false }
                                .navigationTitle("Add a Map")
                                .navigationBarTitleDisplayMode(.inline)
                        }
                    }
                    if showMapMenu {
                        MapMenu(story: story, width: geometry.size.width * 0.8, shown: $showMapMenu, sheet: $sheet)
                            .transition(.move(edge: .leading))
                            .offset(x: mapMenuPosition, y: 0)
                            .zIndex(1)
                    }
                }
                .background(Color.background)
                .sheet(item: $sheet, onDismiss: { sheetDismiss() }) {item in
                    switch item {
                    case .options: OptionsSheet(map: story.displayedMap!, newMap: $newDisplayedMap).presentationDetents([.fraction(0.3)])
                    case .bubbleList: BubbleList()
                    case .addMap: AddMapSheet(story: story, showMapMenu: $showMapMenu).presentationDetents([.fraction(0.2)])
                    }
                }
                .toolbar { menuButton }
                .toolbar { optionsButton }
                .toolbar { bubbleListButton }
            }
            .gesture(drag)
        }
    }
    
    func mapMenuButtonAction() {
        if !showMapMenu {
            withAnimation(.linear(duration: 0.25)) {
                showMapMenu = true
            }
        }
        else {
            closeMapMenu()
        }
    }
    
    func closeMapMenu() {
        withAnimation(.linear(duration: 0.25)) {
            showMapMenu = false
            mapMenuPosition = 0.0
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
    case options, bubbleList, addMap
    var id: RawValue { rawValue }
}
