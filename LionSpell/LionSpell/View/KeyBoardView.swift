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
            ZStack {
                let offset = CGFloat(50 + 2 * options.count)
                let offsetAngle: CGFloat = CGFloat(2) * CGFloat.pi / CGFloat(options.count - 1)
                let initialAngle: CGFloat = offsetAngle / CGFloat(2)
                
                let correction = gameManager.preferences.difficulty == .six ? CGFloat.pi / CGFloat(3.3) : 0
                
                LetterButtonView(letter: String(options.first!), shapeColor: .yellow, rotation: correction)
                let lettersArray = Array(options)
                ForEach(1..<lettersArray.count, id: \.self) { i in
                    LetterButtonView(letter: String(lettersArray[i]), shapeColor: .blue, rotation: -correction)
                        .offset(x: cos(correction + initialAngle + offsetAngle * CGFloat(i)) * offset, y: sin(correction + initialAngle + offsetAngle * CGFloat(i)) * offset)
                }
            }
            DeleteButtonView()
        }
    }
}

// Displays a button for typing a single letter.
struct LetterButtonView: View {
    @EnvironmentObject var gameManager: GameManager
    let letter: String
    let shapeColor: Color
    let rotation: CGFloat
    var body: some View {
        Button(action: gameManager.letterButtonPress(letter: letter)) {
            Text(letter)
                .font(.title.monospaced())
                .foregroundColor(.white)
                .padding(20)
                .background(ShapeView(sides: gameManager.preferences.difficulty.rawValue - 1)
                    .fill(shapeColor)
                    .rotationEffect(Angle(radians: rotation)))
        }
        .padding()
    }
}

struct ShapeView: Shape {
    let sides: Int
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let radius = min(rect.width,rect.height)/2
        path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        let slice = CGFloat(2) * CGFloat.pi/CGFloat(sides)
        for i in 1..<sides{
            let angle = slice * CGFloat(i)
            path.addLine(to: CGPoint(x: rect.midX + cos(angle) * radius, y: rect.midY + sin(angle) * radius))
        }
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
        }
        .disabled(gameManager.deleteButtonDisabled)
        .padding(.leading, 40)
    }
}


struct LetterButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        KeyBoardView(options: "TPESY")
            .environmentObject(GameManager())
    }
}
