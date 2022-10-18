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
            Spacer()
            HideAllMenu()
            Spacer()
            Button(action: manager.toggleTracking) {
                Image(systemName: "location.fill")
            }
            Spacer()
            Button(action: manager.showFavorites) {
                Image(systemName: "star.fill")
                    .foregroundColor(.yellow)
            }
            Spacer()
            Button(action: { manager.shownSheet = .buildingList }) {
                Image(systemName: "magnifyingglass")
            }
        }
        
        NavigationStack {
            CampusMap(manager: manager)
                .toolbar {
                    toolbar
                }
        }
        .sheet(item: $manager.shownSheet) { item in
            switch item {
            case .building: BuildingDetailsSheet().onAppear{ manager.timeTo(manager.selectedBuilding!.coordinate) }
            case .pin: PinSheet().onAppear{ manager.timeTo(manager.selectedPin!.coordinate) }
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
