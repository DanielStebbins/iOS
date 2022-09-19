//
//  BoardAndPieceView.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import SwiftUI

struct BoardAndPieceView: View {
    @EnvironmentObject var manager: Manager
    let pieces: Array<Piece>
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(manager.boardImage)
            ForEach(0..<pieces.count, id: \.self) { i in
                PieceView(piece: pieces[i])
            }
        }
    }
}

struct PieceView: View {
    let piece: Piece
    var body: some View {
        Image(piece.tile.name)
    }
}

struct BoardAndPieceView_Previews: PreviewProvider {
    static var previews: some View {
        BoardAndPieceView(pieces: [Piece.standard, Piece.standard])
            .environmentObject(Manager())
    }
}
