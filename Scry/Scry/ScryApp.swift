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
    var body: some Scene {
        WindowGroup {
            BubbleDetails(bubble: $manager.bubbles[0])
                .environmentObject(manager)
        }
    }
}
