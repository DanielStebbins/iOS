//
//  Preferences.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 9/12/22.
//

import Foundation

// I know the directions said to use String enums, but I really think Int makes more sense for this one.
enum Difficulty: Int, Identifiable, CaseIterable {
    case five = 5
    case six = 6
    case seven = 7
    var id: RawValue { rawValue }
}

enum Language:  String, Identifiable, CaseIterable {
    case english, french
    var id: RawValue { rawValue }
}

struct Preferences {
    var difficulty: Difficulty = .five
    var language: Language = .english
}
