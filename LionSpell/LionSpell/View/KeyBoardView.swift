//
//  KeyBoardView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

// Displays the letter buttons and the delete button.
struct KeyBoardView: View {
    @EnvironmentObject var gameManager: GameManager
    let options: String
    var body: some View {
        HStack {
            ForEach(Array(options), id: \.self) { char in
                LetterButtonView(letter: String(char))
            }
            DeleteButtonView()
        }
    }
}

// Displays a button for typing a single letter.
struct LetterButtonView: View {
    @EnvironmentObject var gameManager: GameManager
    let letter: String
    var body: some View {
        Button(action: gameManager.letterButtonPress(letter: letter)) {
            Text(String(letter))
                .font(.title.monospaced())
                .foregroundColor(.white)
                .padding(10)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2))
        }
    }
}

struct ShapeView: Shape {
//    @EnvironmentObject var gameManager: GameManager
    let sides: Int
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        let slice = CGFloat(2) * CGFloat.pi/CGFloat(sides)
        for i in 1..<sides - 1 {
            let angle = slice * CGFloat(i)
            path.addLine(to: CGPoint(x: cos(angle) * rect.maxX, y: sin(angle) * rect.maxY))
        }
        path.closeSubpath()
        return path
    }
}

// Displays the delete button, for removing one letter.
struct DeleteButtonView: View {
    @EnvironmentObject var gameManager: GameManager
    var body: some View {
        Button(action: gameManager.deleteButtonPress) {
            Image(systemName: "delete.left")
                .foregroundColor({gameManager.deleteButtonDisabled ? .gray : .red}())
                .padding([.top, .bottom])
                .padding([.leading, .trailing], 8)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2))
        }
        .disabled(gameManager.deleteButtonDisabled)
    }
}


struct LetterButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        KeyBoardView(options: "TPESY")
            .environmentObject(GameManager())
    }
}
