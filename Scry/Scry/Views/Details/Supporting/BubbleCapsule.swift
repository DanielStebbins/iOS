//
//  BubbleCapsule.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/11/22.
//

import SwiftUI

struct BubbleCapsule<T>: View where T: Bubble{
    @ObservedObject var bubble: T
    var font: Font?
    
    var body: some View {
        NavigationLink(value: bubble) {
            Text(bubble.name!)
                .lineLimit(1)
                .font(font ?? .body)
                .padding([.leading, .trailing], 7)
                .padding([.top, .bottom], 5)
                .background {
                    Capsule()
                        .fill(Color(bubble: bubble))
                }
        }
        .navigationDestination(for: Character.self) {_ in
            CharacterView(character: bubble as! Character)
        }
        .navigationDestination(for: Faction.self) {_ in
            FactionView(faction: bubble as! Faction)
        }
        .navigationDestination(for: Item.self) {_ in
            ItemView(item: bubble as! Item)
        }
        .navigationDestination(for: Location.self) {_ in
            LocationView(location: bubble as! Location)
        }
    }
}
