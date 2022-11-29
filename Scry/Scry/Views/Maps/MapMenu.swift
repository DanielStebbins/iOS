//
//  MapMenu.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct MapMenu: View {
    var width: CGFloat
    
    @EnvironmentObject var manager: Manager
    @Environment(\.managedObjectContext) var context
    @State var showAddMapSheet: Bool = false

    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var maps: FetchedResults<Map>
    
    var body: some View {
        ScrollView {
            HeaderView(title: "Maps", toggle: $showAddMapSheet)
                .padding()
            ForEach(maps) {map in
                Button(action: { manager.selectedMap = map }) {
                    Text(map.name!)
                }
                .background(.red)
            }
        }
        .frame(width: width)
        .background(.gray, ignoresSafeAreaEdges: [])
        .sheet(isPresented: $showAddMapSheet) {
            AddMapSheet()
        }
    }
}

