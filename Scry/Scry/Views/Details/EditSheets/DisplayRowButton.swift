//
//  DisplayRowButton.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/20/22.
//

import SwiftUI

struct DisplayRowButton: View {
    let text: String
    @Binding var display: Bool
    
    var body: some View {
        Button(action: { display.toggle() }) {
            HStack {
                Text(text)
                Spacer()
                if display {
                    Image(systemName: "checkmark")
                }
            }
        }
        .buttonStyle(.bordered)
    }
}
