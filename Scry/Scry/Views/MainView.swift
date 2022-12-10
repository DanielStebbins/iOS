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
    @State var mapMenuFullyOpen: Bool = false
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

        GeometryReader { geometry in
            let drag = DragGesture()
                .onChanged { value in
                    if mapMenuFullyOpen{
                        mapMenuPosition = min(0, value.translation.width)
                    }
                    else {
                        mapMenuPosition = max(-geometry.size.width, value.translation.width - geometry.size.width)
                    }
                    
                    if !showMapMenu {
                        showMapMenu = true
                        mapMenuPosition = -geometry.size.width
                    }
                }
                .onEnded { drag in
                    if mapMenuFullyOpen {
                        drag.translation.width < -50 ? closeMapMenu() : openMapMenu()
                    }
                    else {
                        drag.translation.width > 70 ? openMapMenu() : closeMapMenu()
                    }
                }
            
            NavigationStack {
                ZStack(alignment: .leading) {
                    ZStack(alignment: .center) {
                        if story.displayedMap != nil {
                            ToolbarMapView(map: story.displayedMap!, mapMenuFullyOpen: mapMenuFullyOpen, closeMapMenu: { closeMapMenu() })
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
                        MapMenu(story: story, width: geometry.size.width * 0.8, close: { closeMapMenu() }, sheet: $sheet)
                            .transition(.move(edge: .leading))
                            .offset(x: mapMenuPosition, y: 0)
                            .zIndex(1)
                    }
                }
                .background(Color.background)
                .toolbar { menuButton }
                .toolbar { optionsButton }
                .toolbar { bubbleListButton }
            }
            .sheet(item: $sheet, onDismiss: { sheetDismiss() }) {item in
                switch item {
                case .options: OptionsSheet(map: story.displayedMap!, newMap: $newDisplayedMap).presentationDetents([.fraction(0.3)])
                case .bubbleList: BubbleList()
                case .addMap: AddMapSheet(story: story, showMapMenu: $showMapMenu).presentationDetents([.fraction(0.2)])
                }
            }
            .gesture(drag)
        }
    }
    
    func mapMenuButtonAction() {
        if !mapMenuFullyOpen {
            openMapMenu()
        }
        else {
            closeMapMenu()
        }
    }
    
    func openMapMenu() {
        withAnimation(.linear(duration: 0.25)) {
            showMapMenu = true
            mapMenuPosition = 0.0
        }
        mapMenuFullyOpen = true
    }
    
    func closeMapMenu() {
        withAnimation(.linear(duration: 0.25)) {
            showMapMenu = false
            mapMenuPosition = 0.0
        }
        mapMenuFullyOpen = false
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
