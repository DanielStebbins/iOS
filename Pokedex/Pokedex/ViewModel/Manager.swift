//
//  Manager.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import Foundation

class Manager: ObservableObject {
    @Published var model = Model()
    
    func leadingZeroID(of pokemon: Pokemon) -> String {
        String(format: "%03d", pokemon.id)
    }
    
    func formatHeight(of pokemon: Pokemon) -> String {
        String(format: "%.2f", pokemon.height)
    }
    
    func formatWeight(of pokemon: Pokemon) -> String {
        String(format: "%.1f", pokemon.weight)
    }
}

//extension Double {
//    var removeTrailingZeros: String {
//        let nf = NumberFormatter()
//        nf.minimumFractionDigits = 0
//        nf.maximumFractionDigits = 4
//        return nf.stringFromNumber(NSNumber(self))!
//    }
//}
