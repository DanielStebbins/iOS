//
//  PieceView.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import SwiftUI

struct PieceView: View {
    let piece: Piece
    var body: some View {
        Image(piece.tile.name)
    }
}

struct PieceView_Previews: PreviewProvider {
    static var previews: some View {
        PieceView(piece: Piece.standard)
    }
}
