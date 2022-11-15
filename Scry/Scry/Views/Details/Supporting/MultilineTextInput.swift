//
//  MultilineTextInput.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

struct MultilineTextInput: View {
    let title: String
    @Binding var text: String
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
            TextField(title, text: $text, axis: .vertical)
                .textFieldStyle(.roundedBorder)
        }
        .padding()
    }
}

