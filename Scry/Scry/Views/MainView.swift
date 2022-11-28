//
//  MapContainer.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct MainView: View {
    var map: Map?
    @Environment(\.managedObjectContext) var context
    @State var showMenu: Bool = false
    @State var sheet: ShownSheet?
    
    var body: some View {
        let drag = DragGesture()
            .onEnded {
                if $0.translation.width < -30 {
                    withAnimation {
                        self.showMenu = false
                    }
                }
            }
        
        NavigationStack {
            ZStack(alignment: .topLeading) {
                if let map {
                    MapView(map: map)
                        .disabled(showMenu)
                }
                else {
                    Text("Select a Map")
                }
                if showMenu {
                    MapMenu()
                        .frame(width: 200)
                        .transition(.move(edge: .leading))
                        .gesture(drag)
                }
            }
            .sheet(item: $sheet) {item in
                switch item {
                case .options: OptionsSheet()
                }
            }
            .navigationBarItems(leading: (
                Button(action: { withAnimation { showMenu.toggle() } }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                }))
            
            .navigationBarItems(trailing: (
                Button(action: { withAnimation { sheet = .options } }) {
                    Image(systemName: "gear")
                        .imageScale(.large)
                }))
        }
    }
}

enum ShownSheet: String, Identifiable {
    case options
    var id: RawValue { rawValue }
}
