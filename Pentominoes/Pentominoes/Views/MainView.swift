//
//  ContentView.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color("PSUBlue")
                .ignoresSafeArea()
            BoardAndButtonsView()
                .padding(.top)
            ForEach($manager.model.pieces) { $p in
                PieceView(piece: $p)
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Manager())
    }
}
