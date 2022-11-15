//
//  ScryApp.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

@main
struct ScryApp: App {
    @StateObject var manager = Manager()
    @Environment(\.scenePhase) var scenePhase
    var body: some Scene {
        WindowGroup {
            BubbleList()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
                .onChange(of: scenePhase) { newValue in
                    switch scenePhase {
                    case .inactive:
                        try? manager.container.viewContext.save()
                    default:
                        break
                    }
                }
        }
    }
}
