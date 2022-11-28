//
//  MapMenu.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct MapMenu: View {
    @Environment(\.managedObjectContext) var context
    @State var showAddMapSheet: Bool = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var maps: FetchedResults<Map>
    
    var body: some View {
        ScrollView {
            HeaderView(title: "Maps", toggle: $showAddMapSheet)
                .padding()
            ForEach(maps) {map in
                Text(map.name!)
                    .background(.red)
            }
        }
        .frame(width: 200)
        .background(.gray)
        .sheet(isPresented: $showAddMapSheet) {
            AddMapSheet()
        }
    }
}

