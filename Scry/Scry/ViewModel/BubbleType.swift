//
//  BubbleTypes.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/11/22.
//

import Foundation

// An Enum to convert from bubble types (swift's typing) to an enum type I can more easily work with.
enum BubbleType: String, Identifiable, CaseIterable {
    case character = "Character", faction = "Faction", item = "Item", location = "Location"
    var id: RawValue { rawValue }
    var imageName: String {
        switch self {
        case .character: return "person"
        case .faction: return "flag"
        case .item: return "wand.and.stars"
        case .location: return "location"
        }
    }
    init<T>(type: T.Type) where T: Bubble {
        switch type {
        case is Character.Type: self = .character
        case is Faction.Type: self = .faction
        case is Item.Type: self = .item
        case is Location.Type: self = .location
        default: self = .character
        }
    }
    init(bubble: Bubble) {
        switch bubble {
        case bubble as Character: self = .character
        case bubble as Faction: self = .faction
        case bubble as Item: self = .item
        case bubble as Location: self = .location
        default: self = .character
        }
    }
}
