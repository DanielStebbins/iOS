//
//  ContentView.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var manager : Manager
    var body: some View {
        
        let buildingListToolbarItem = ToolbarItem(placement: .navigationBarTrailing) {
            BuildingListButton()
        }
        
        NavigationStack {
            CampusMap()
                .toolbar {
                    buildingListToolbarItem
                }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
