//
//  DeleteButton.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct DeleteButton {
    let dismiss: DismissAction
    var dismissParent: DismissAction? = nil
    let deleteAction: () -> Void
    var toolbarItem: ToolbarItem<(), Button<Image>> {
        ToolbarItem(placement: .navigationBarLeading) {
            Button(role: .destructive, action: { dismiss(); deleteAction(); if dismissParent != nil { dismissParent!() } }) {
                Image(systemName: "trash")
            }
        }
    }
}
