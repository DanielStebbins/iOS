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
            let map = Map(context: manager.container.viewContext)
            MapView(map: map)
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
                .onChange(of: scenePhase) { newValue in
                    switch scenePhase {
                    case .inactive:
                        try? manager.container.viewContext.save()
                        break
                    default:
                        break
                    }
                }
                .onAppear {
                    let character = Character(context: manager.container.viewContext)
                    character.name = "Test"
                    character.red = 100
                    character.green = 100
                    character.blue = 100
                    let mappedBubble = MappedBubble(context: manager.container.viewContext)
                    mappedBubble.bubble = character
                    mappedBubble.map = map
                    map.addToMappedBubbles(mappedBubble)
                }
        }
    }
}
