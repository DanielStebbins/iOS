//
//  CharacterView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct CharacterView: View {
    var character: Character
    var body: some View {
        VStack {
            BubbleView(bubble: character)
        }
    }
}
