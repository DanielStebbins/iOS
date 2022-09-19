//
//  BoardButtonColumn.swift
//  Pentominoes
//
//  Created by Stebbins, Daniel Ross on 9/19/22.
//

import SwiftUI

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
            Image(manager.toButtonImage(num: boardNum))
        }
    }
}

struct BoardButtonColumn_Previews: PreviewProvider {
    static var previews: some View {
        ButtonColumn(boardNums: [0, 1, 2], SFImage: "arrow.counterclockwise.circle")
            .environmentObject(Manager())
    }
}
