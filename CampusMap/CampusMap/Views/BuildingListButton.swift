//
//  BuildingList.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import SwiftUI




struct BuildingListButton: View {
    @EnvironmentObject var manager : Manager
    var body: some View {
        Menu {
            ForEach(manager.model.buildings) { building in
                Text(building.name)
            }
        } label: {
            Image(systemName: "magnifyingglass")
        }
    }
}

struct BuildingList_Previews: PreviewProvider {
    static var previews: some View {
        BuildingListButton()
    }
}
