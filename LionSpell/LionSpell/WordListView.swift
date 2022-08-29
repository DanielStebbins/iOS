//
//  WordListView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct WordListView: View {
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(0..<11) {
                    Text("Row \($0)")
                }
            }
        }
    }
}

struct WordListView_Previews: PreviewProvider {
    static var previews: some View {
        WordListView()
    }
}
