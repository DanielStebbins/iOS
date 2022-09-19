//
//  BoardAndPieceView.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import SwiftUI

struct BoardAndPieceView: View {
    let board: String
    let pieces: Array<Piece>
    var body: some View {
        ZStack(alignment: .topLeading) {
            Image(board)
            ForEach(0..<pieces.count, id: \.self) { i in
                PieceView(piece: pieces[i])
            }
        }
    }
}

struct BoardAndPieceView_Previews: PreviewProvider {
    static var previews: some View {
        BoardAndPieceView(board: "Board0", pieces: [Piece.standard, Piece.standard])
    }
}
