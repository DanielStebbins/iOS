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
        ZStack(alignment: .top) {
            Color("PSUBlue")
                 .ignoresSafeArea()
            HStack {
                ButtonColumn(boardNums: [0, 1, 2], SFImage: "arrow.counterclockwise.circle")
                BoardAndPieceView(board: "Board0", pieces: [Piece.standard, Piece.standard])
                ButtonColumn(boardNums: [3, 4, 5], SFImage: "arrow.forward.circle")
            }
            .padding(.top)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Manager())
    }
}
