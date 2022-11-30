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
    @State var showMenu: Bool = false
    @State var sheet: ShownSheet?
    
    var body: some View {
        let menuButton = ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { withAnimation { showMenu.toggle() } }) {
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
        
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -30 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        GeometryReader { geometry in
            NavigationStack {
                ZStack(alignment: .leading) {
                    Color.clear
                    if story.displayedMap != nil {
                        MapView(map: story.displayedMap!, width: geometry.size.width)
                            .disabled(showMenu)
                    }
                    else {
                        Text("The fighter after the lich casts disintegrate:")
                    }
                    if showMenu {
                        MapMenu(story: story, width: geometry.size.width * 0.8)
                            .transition(.move(edge: .leading))
                            .gesture(drag)
                            .zIndex(1)
                    }
                    
                }
                .navigationTitle(story.displayedMap == nil ? "Select a Map" : story.displayedMap!.name!)
                .navigationBarTitleDisplayMode(.inline)
                .sheet(item: $sheet, onDismiss: { story.displayedMap = nil }) {item in
                    switch item {
                    case .options: OptionsSheet(map: story.displayedMap!)
                    }
                }
                .toolbar { menuButton }
                .toolbar { optionsButton }
            }
        }
    }
}

enum ShownSheet: String, Identifiable {
    case options
    var id: RawValue { rawValue }
}
