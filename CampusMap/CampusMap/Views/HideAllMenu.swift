//
//  HideAllMenu.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/17/22.
//

import SwiftUI

struct HideAllMenu: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        Menu {
                Button("Buildings") {
                    manager.hideAllBuildings()
                }
                Button("Favorites") {
                    manager.hideFavorites()
                }
                Button("Pins") {
                    manager.hideAllPins()
                }
                Button("Route") {
                    manager.route = nil
                }
        } label: {
            Image(systemName: "eye.slash")
        }
    }
}

struct HideAllMenu_Previews: PreviewProvider {
    static var previews: some View {
        HideAllMenu()
    }
}
