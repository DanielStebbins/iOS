//
//  BoardButtonColumn.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import SwiftUI

struct BoardAndButtonsView: View {
    @EnvironmentObject var manager: Manager
    var body: some View {
        HStack {
            ButtonColumn(boardNums: [0, 1, 2], SFImage: "arrow.counterclockwise.circle")
            Image(manager.model.boardNames[manager.board])
            ButtonColumn(boardNums: [3, 4, 5], SFImage: "arrow.forward.circle")
        }
    }
}

struct ButtonColumn: View {
    @EnvironmentObject var manager: Manager
    let boardNums: Array<Int>
    let SFImage: String
    var body: some View {
        VStack {
            ForEach(0..<boardNums.count, id: \.self) { i in
                BoardButtonView(boardNum: boardNums[i])
            }
            Button(action: {}) {
                Image(systemName: SFImage)
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .padding([.leading, .trailing], 50)
                    .padding()
            }
        }
    }
}

struct BoardButtonView: View {
    @EnvironmentObject var manager: Manager
    let boardNum: Int
    var body: some View {
        Button(action: manager.boardButtonPress(num: boardNum)) {
            Image(manager.model.buttonNames[boardNum])
        }
        .padding()
    }
}

struct BoardButtonColumn_Previews: PreviewProvider {
    static var previews: some View {
        ButtonColumn(boardNums: [0, 1, 2], SFImage: "arrow.counterclockwise.circle")
            .environmentObject(Manager())
    }
}
