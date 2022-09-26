//
//  PieceView.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/26/22.
//

import SwiftUI

struct PieceView: View {
    @EnvironmentObject var manager: Manager
    @Binding var piece: Piece
    @State private var offset = CGSize.zero
    
    var body: some View {
        
        let move = DragGesture()
            .onChanged { value in
                offset = value.translation
            }
            .onEnded { value in
                piece.moveBy(Double(Int(value.translation.width / CGFloat(manager.tileSize))), Double(Int(value.translation.height / CGFloat(manager.tileSize))))
                offset = CGSize.zero
                manager.resetButtonDisabled = false;
            }
        
        FlippablePieceView(piece: $piece)
            .offset(offset)
            .position(CGPoint(x: Int(piece.center.x * manager.tileSize - manager.boardXOffset), y: Int(piece.center.y * manager.tileSize)))
            .gesture(move)
    }
}

struct FlippablePieceView: View {
    @EnvironmentObject var manager: Manager
    @Binding var piece: Piece
    var body: some View {
        
        let flip = LongPressGesture()
            .onEnded { _ in
                piece.position.isFlipped.toggle()
                manager.resetButtonDisabled = false;
            }
        
        RotatablePieceView(piece: $piece)
            .gesture(flip)
            .rotation3DEffect(.degrees(piece.position.isFlipped ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
    }
}

struct RotatablePieceView: View {
    @EnvironmentObject var manager: Manager
    @Binding var piece: Piece
    var body: some View {
        
        let rotate = TapGesture()
            .onEnded {
                piece.position.rotations = (piece.position.rotations + 1) % 4
                manager.resetButtonDisabled = false;
            }
        
        Image(piece.tile.name)
            .gesture(rotate)
            .rotationEffect(.degrees(Double(90 * piece.position.rotations)))
    }
}
