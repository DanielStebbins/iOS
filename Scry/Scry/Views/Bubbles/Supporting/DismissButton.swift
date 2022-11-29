//
//  DismissButton.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct DismissButton {
    var dismiss: DismissAction
    var toolbarItem: ToolbarItem<(), Button<Text>> {
        ToolbarItem(placement: .navigationBarTrailing) {
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}
