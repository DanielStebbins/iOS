//
//  RootView.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 11/9/22.
//

import SwiftUI

struct RootView: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            PokemonListView()
                .tabItem {
                    Label("List", systemImage: "list.bullet")
                }
        }
    }
}
