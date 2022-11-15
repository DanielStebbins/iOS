//
//  BubbleList.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct BubbleList: View {
    @EnvironmentObject var manager: Manager
    @Environment(\.managedObjectContext) var context
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var characters: FetchedResults<Character>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var factions: FetchedResults<Faction>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var items: FetchedResults<Item>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var locations: FetchedResults<Location>

    @State private var isAddingCharacter = false
    @State private var isAddingFaction = false
    @State private var isAddingItem = false
    @State private var isAddingLocation = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    EditField(isEditing: $isAddingCharacter, template: "Enter Name", adding: { name in addCharacter(name) })
                    ForEach(characters) { c in
                        NavigationLink(destination: CharacterView(character: c), label: { Text(c.name ?? "No Name") })
                    }
                } header: {
                    HeaderView(title: "Characters", toggle: $isAddingCharacter)
                }
                
                Section {
                    EditField(isEditing: $isAddingFaction, template: "Enter Name", adding: { name in addFaction(name) })
                    ForEach(factions) { f in
                        NavigationLink(destination: FactionView(faction: f), label: { Text(f.name ?? "No Name") })
                    }
                } header: {
                    HeaderView(title: "Factions", toggle: $isAddingFaction)
                }
                
                Section {
                    EditField(isEditing: $isAddingItem, template: "Enter Name", adding: { name in addItem(name) })
                    ForEach(items) { i in
                        NavigationLink(destination: ItemView(item: i), label: { Text(i.name ?? "No Name")})
                    }
                } header: {
                    HeaderView(title: "Items", toggle: $isAddingItem)
                }
                
                Section {
                    EditField(isEditing: $isAddingLocation, template: "Enter Name", adding: { name in addLocation(name) })
                    ForEach(locations) { l in
                        NavigationLink(destination: LocationView(location: l), label: { Text(l.name ?? "No Name")})
                    }
                } header: {
                    HeaderView(title: "Locations", toggle: $isAddingLocation)
                }
            }
            .padding()
            .navigationTitle("Bubble List")
        }
    }
    
    func addCharacter(_ name: String) {
        let character = Character(context: context)
        character.name = name
    }
    
    func addFaction(_ name: String) {
        let faction = Faction(context: context)
        faction.name = name
    }
    
    func addItem(_ name: String) {
        let item = Item(context: context)
        item.name = name
    }
    
    func addLocation(_ name: String) {
        let location = Location(context: context)
        location.name = name
    }
}

struct HeaderView : View {
    var title : String
    @Binding var toggle : Bool
    var body : some View {
        HStack {
            Text(title)
            Spacer()
            Button(action:{toggle.toggle()}) {
                Image(systemName: "plus")
            }
        }
    }
}
