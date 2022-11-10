//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import SwiftUI

@main
struct PokedexApp: App {
    @StateObject var manager = Manager()
    @Environment(\.scenePhase) var scenePhase
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(manager)
        }
        .onChange(of: scenePhase) { phase in
            switch phase {
            case .background:
                break
            case .active:
                break
            case .inactive:
                manager.save()
            @unknown default:
                assert(false, "Unknown Scene Phase")
            }
        }
    }
}
