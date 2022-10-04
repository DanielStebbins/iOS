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
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(manager)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                manager.save()
            case .active:
                break
            case .inactive:
                break
            @unknown default:
                assert(false, "Unknown Scene Phase")
            }
        }
    }
}
