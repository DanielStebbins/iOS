//
//  CampusMapApp.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import SwiftUI

@main
struct CampusMapApp: App {
    @StateObject var manager = Manager()
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(manager)
        }
    }
}
