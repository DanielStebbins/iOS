//
//  ItemView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct ItemView: View {
    var item: Item
    var body: some View {
        VStack {
            BubbleView(bubble: item)
        }
    }
}

