//
//  TypeUnknownBubbleView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/5/22.
//

import SwiftUI

struct UnknownBubbleView: View {
    @ObservedObject var bubble: Bubble
    
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        ClosableView {
            ZStack {
                switch bubble {
                case let bubble as Character: CharacterView(character: bubble)
                case let bubble as Faction: FactionView(faction: bubble)
                case let bubble as Item: ItemView(item: bubble)
                case let bubble as Location: LocationView(location: bubble)
                default: Text("Error! Unknown Bubble Type")
                }
            }
            .navigationDestination(for: Character.self) {value in
                CharacterView(character: value)
            }
            .navigationDestination(for: Faction.self) {value in
                FactionView(faction: value)
            }
            .navigationDestination(for: Item.self) {value in
                ItemView(item: value)
            }
            .navigationDestination(for: Location.self) {value in
                LocationView(location: value)
            }
        }
    }
}
