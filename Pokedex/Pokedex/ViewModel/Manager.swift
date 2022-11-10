//
//  Manager.swift
//  Pokedex
//
//  Created by Stebbins, Daniel Ross on 10/24/22.
//

import Foundation

class Manager: ObservableObject {
    @Published var pokemon: [Pokemon]
    @Published var selectedType: PokemonType?
    
    private var storageManager: StorageManager<[Pokemon]>
    
    init() {
        storageManager = StorageManager<[Pokemon]>(name: "pokedex")
        pokemon = storageManager.modelData ?? []
        for i in pokemon.indices {
            if(pokemon[i].captured == nil) {
                pokemon[i].captured = false
            }
        }
    }
    
    func indicesForType(_ type: PokemonType) -> [Int] {
        return pokemon.indices.filter({ pokemon[$0].types.contains(type) })
    }
    
    func indicesForIDs(_ ids: [Int]) -> [Int] {
        return pokemon.indices.filter({ ids.contains(pokemon[$0].id) })
    }
    
    var selectedIndices: [Int] {
        if let selectedType {
            return indicesForType(selectedType)
        }
        else {
            return Array(pokemon.indices)
        }
    }
    
    func leadingZeroID(of pokemon: Pokemon) -> String {
        String(format: "%03d", pokemon.id)
    }
    
    func formatHeight(of pokemon: Pokemon) -> String {
        String(format: "%.2f", pokemon.height)
    }
    
    func formatWeight(of pokemon: Pokemon) -> String {
        String(format: "%.1f", pokemon.weight)
    }
    
    func save() {
        storageManager.save(pokemon)
    }
}
