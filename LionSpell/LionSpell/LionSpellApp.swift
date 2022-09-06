//
//  LionSpellApp.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

@main
struct LionSpellApp: App {
    @StateObject var gameManager = GameManager()
    var body: some Scene {
        WindowGroup {
            LionSpellView()
                .environmentObject(gameManager)
        }
    }
}
