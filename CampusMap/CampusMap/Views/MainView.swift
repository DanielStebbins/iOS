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
            Button(action: { manager.tracking = MapUserTrackingMode.follow; print(manager.tracking) }) {
                Image(systemName: "location.fill")
            }
            .disabled(manager.tracking == .follow)
            Spacer()
            Button(action: manager.hideAll) {
                Image(systemName: "eye.slash")
            }
            Spacer()
            Button(action: manager.showFavorites) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            Spacer()
            Button(action: manager.hideFavorites) {
                Image(systemName: "star")
                    .foregroundColor(.yellow)
            }
            Spacer()
            Button(action: { manager.shownSheet = .buildingList }) {
                Image(systemName: "magnifyingglass")
            }
        }
        
        NavigationStack {
            CampusMap()
                .toolbar {
                    toolbar
                }
                .confirmationDialog("Building", isPresented: $manager.showConfirmation, presenting: manager.selectedBuilding) { building in
                    Button("Details") {
                        manager.selectedBuilding = building
                        manager.shownSheet = .details
                    }
                } message: { building in
                    Text(building.name)
                }
                .sheet(item: $manager.shownSheet) { item in
                    switch item {
                    case .details: BuildingDetailsSheet()
                    case .buildingList: BuildingListSheet()
                    }
                }
        }
        
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
