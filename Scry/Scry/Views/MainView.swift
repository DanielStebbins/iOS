//
//  MapContainer.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var manager: Manager
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
            if manager.selectedMap != nil {
                Button(action: { withAnimation { sheet = .options } }) {
                    Image(systemName: "gearshape")
                        .imageScale(.large)
                }
            }
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
                    if let map = manager.selectedMap {
                        MapView(map: map)
                            .disabled(showMenu)
                    }
                    else {
                        Text("The fighter after the lich casts disintegrate:")
                    }
                    if showMenu {
                        MapMenu(width: geometry.size.width * 0.8)
                            .transition(.move(edge: .leading))
                            .gesture(drag)
                            .zIndex(1)
                    }
                    
                }
                .navigationTitle(manager.selectedMap == nil ? "Select a Map" : manager.selectedMap!.name!)
                .navigationBarTitleDisplayMode(.inline)
                .sheet(item: $sheet) {item in
                    switch item {
                    case .options: OptionsSheet(map: Binding($manager.selectedMap)!)
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
