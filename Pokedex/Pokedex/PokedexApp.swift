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
    var body: some Scene {
        WindowGroup {
            PokemonListView()
                .environmentObject(manager)
        }
    }
}
