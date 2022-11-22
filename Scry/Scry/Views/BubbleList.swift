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
                    SingleLineTextInput(isEditing: $isAddingCharacter, template: "Enter Name", adding: { name in addCharacter(name) })
                    ForEach(characters) { c in
                        BubbleCapsule(bubble: c)
                    }
                } header: {
                    HeaderView(title: "Characters", toggle: $isAddingCharacter)
                }
                
                Section {
                    SingleLineTextInput(isEditing: $isAddingFaction, template: "Enter Name", adding: { name in addFaction(name) })
                    ForEach(factions) { f in
                        BubbleCapsule(bubble: f)
                    }
                } header: {
                    HeaderView(title: "Factions", toggle: $isAddingFaction)
                }
                
                Section {
                    SingleLineTextInput(isEditing: $isAddingItem, template: "Enter Name", adding: { name in addItem(name) })
                    ForEach(items) { i in
                        BubbleCapsule(bubble: i)
                    }
                } header: {
                    HeaderView(title: "Items", toggle: $isAddingItem)
                }
                
                Section {
                    SingleLineTextInput(isEditing: $isAddingLocation, template: "Enter Name", adding: { name in addLocation(name) })
                    ForEach(locations) { l in
                        BubbleCapsule(bubble: l)
                    }
                } header: {
                    HeaderView(title: "Locations", toggle: $isAddingLocation)
                }
            }
            .listStyle(.plain)
            .padding()
            .navigationTitle("Bubble List")
        }
    }
    
    func addCharacter(_ name: String) {
        let character = Character(context: context)
        setValues(bubble: character, name: name)
    }
    
    func addFaction(_ name: String) {
        let faction = Faction(context: context)
        setValues(bubble: faction, name: name)
    }
    
    func addItem(_ name: String) {
        let item = Item(context: context)
        setValues(bubble: item, name: name)
    }
    
    func addLocation(_ name: String) {
        let location = Location(context: context)
        setValues(bubble: location, name: name)
    }
    
    func setValues(bubble: Bubble, name: String) {
        bubble.name = name
        bubble.red = Color.random
        bubble.green = Color.random
        bubble.blue = Color.random
        bubble.notes = ""
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

//struct ListElement: View {
//    var title: String
//    @Binding var isAdding: Bool
//    
//    var body: some View {
//        Section {
//            SingleLineTextInput(isEditing: $isAdding, template: "Enter Name", adding: { name in addCharacter(name) })
//            ForEach(characters) { c in
//                NavigationLink(destination: CharacterView(character: c)) {
//                    BubbleCapsule(text: c.name!, color: Color(bubble: c))
//                }
//            }
//        } header: {
//            HeaderView(title: title, toggle: $isAdding)
//        }
//    }
//}
