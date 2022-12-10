//
//  TypeUnknownBubbleView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/5/22.
//

import SwiftUI

struct UnknownBubbleView: View {
    @Binding var bubble: Bubble
    
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        let closeButton = ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
        
        NavigationStack {
            ZStack {
                switch bubble {
                case let bubble as Character: CharacterView(character: bubble)
                case let bubble as Faction: FactionView(faction: bubble)
                case let bubble as Item: ItemView(item: bubble)
                case let bubble as Location: LocationView(location: bubble)
                default: Text("Error! Unknown Bubble Type")
                }
            }
            .toolbar { closeButton }
        }
    }
}
