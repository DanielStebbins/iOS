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
                .confirmationDialog("Building", isPresented: $manager.showConfirmation, presenting: manager.selectedBuilding) { building in
                    Button(building.isFavorite! ? "Unfavorite" : "Favorite") {
                        manager.toggleFavorite(building)
                    }
                    Button("Details") {
                        manager.selectedBuilding = building
                        manager.showSheet = true
                    }
                } message: { building in
                    Text(building.name)
                }
                .sheet(isPresented: $manager.showSheet, content: {
                    BuildingDetails(building: manager.selectedBuilding)
                })
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
