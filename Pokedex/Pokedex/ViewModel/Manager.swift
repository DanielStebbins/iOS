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
    @Published var captured: [Int]
    
    private var storageManager: StorageManager<[Pokemon]>
    
    init() {
        storageManager = StorageManager<[Pokemon]>(name: "pokedex")
        var _pokemon = storageManager.modelData ?? []
        var _captured: [Int] = []
        for i in _pokemon.indices {
            if(_pokemon[i].captured == nil) {
                _pokemon[i].captured = false
            }
            else if(_pokemon[i].captured!) {
                _captured.append(i)
            }
        }
        pokemon = _pokemon
        captured = _captured
    }
    
    func captureRelease(_ p: Pokemon) {
        let index = pokemon.firstIndex(where: { $0.id == p.id })!
        if(p.captured!) {
            captured.append(index)
            captured.sort(by: { a, b in
                pokemon[a].id < pokemon[b].id
            })
        }
        else {
            captured.remove(at: captured.firstIndex(of: index)!)
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
