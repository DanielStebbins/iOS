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
            ForEach(0..<manager.model.pieces.count, id: \.self) { i in
                PieceView(piece: manager.model.pieces[i])
            }
        }
    }
}
    
struct PieceView: View {
    @EnvironmentObject var manager: Manager
    let piece: Piece
    var body: some View {
        Image(piece.tile.name)
            .position(CGPoint(x: piece.center.x * manager.tileSize, y: piece.center.y * manager.tileSize))
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Manager())
    }
}
