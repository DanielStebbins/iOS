//
//  ContentView.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import SwiftUI
import MapKit

struct MainView: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        let toolbar = ToolbarItemGroup(placement: .bottomBar) {
            MapTypeMenu()
            HideAllMenu()
            Button(action: manager.toggleTracking) {
                Image(systemName: "location.fill")
            }
            Button(action: manager.showFavorites) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            Button(action: { manager.shownSheet = .buildingList }) {
                Image(systemName: "magnifyingglass")
            }
        }
        
        NavigationStack {
            CampusMap(manager: manager)
                .toolbar {
                    toolbar
                }
                .confirmationDialog("Pin", isPresented: $manager.showConfirmation, presenting: manager.selectedPin) { pin in
                    Button("Directions") {
                        
                    }
                    Button("Delete") {
                        manager.deletePin()
                    }
                }
        }
        .sheet(item: $manager.shownSheet) { item in
            switch item {
            case .details: BuildingDetailsSheet().onAppear{ manager.routeToSelectedBuilding() }
            case .buildingList: BuildingListSheet()
            }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
