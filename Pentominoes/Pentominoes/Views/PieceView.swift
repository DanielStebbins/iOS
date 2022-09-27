//
//  PieceView.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/26/22.
//

import SwiftUI

// I tried many different orderings for the view modifiers.
// I ended up prioritizing working gestures and correctly displayed solutions over following the hints to the letter.
// For some reason, the flip's .rotation3DEffect has to be applied before the rotation's .rotationEffect
// and the rotation's TapGesture has to be applied before the flip's LongPressGesture for everything to work properly, so that's how I have it.
struct PieceImageView: View {
    @EnvironmentObject var manager: Manager
    @Binding var piece: Piece

    var body: some View {
        Image(piece.tile.name)
            .rotation3DEffect(.degrees(piece.position.isFlipped ? 180 : 0), axis: (x: 0.0, y: 1.0, z: 0.0))
            .rotationEffect(.degrees(Double(90 * piece.position.rotations)))
    }
}

struct RotatablePieceView: View {
    @EnvironmentObject var manager: Manager
    @Binding var piece: Piece
    
    var body: some View {
        let rotate = TapGesture()
            .onEnded {
                // I would reset it using %4 but it makes the animation go counterclockwise on the 4th tap.
                piece.position.rotations += 1
                manager.resetButtonDisabled = false;
            }
        
        PieceImageView(piece: $piece)
            .gesture(rotate)
            .animation(.default, value: piece.position.rotations)
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
            .animation(.default, value: piece.position.isFlipped)
    }
}

struct PieceView: View {
    @EnvironmentObject var manager: Manager
    @Binding var piece: Piece
    @State private var offset = CGSize.zero
    @State private var scale = CGSize(width: 1, height: 1)
    
    var body: some View {
        let move = DragGesture()
            .onChanged { value in
                offset = value.translation
                scale = CGSize(width: 1.2, height: 1.2)
            }
            .onEnded { value in
                piece.moveBy(Double(Int(value.translation.width / CGFloat(manager.tileSize))), Double(Int(value.translation.height / CGFloat(manager.tileSize))))
                offset = CGSize.zero
                manager.resetButtonDisabled = false;
                scale = CGSize(width: 1, height: 1)
            }
        
        FlippablePieceView(piece: $piece)
            .scaleEffect(scale)
            .offset(offset)
            .position(CGPoint(x: Int(piece.center.x * manager.tileSize - manager.boardXOffset), y: Int(piece.center.y * manager.tileSize)))
            .gesture(move)
            .animation(.linear(duration: 0.3), value: scale)
            .animation(.linear, value: piece.position)
    }
}
