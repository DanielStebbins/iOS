//
//  BubbleList.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct BubbleList: View {
    @State var search: String = ""
    var body: some View {
        NavigationStack {
            List {
                ListSection<Character>(search: $search)
                ListSection<Faction>(search: $search)
                ListSection<Item>(search: $search)
                ListSection<Location>(search: $search)
            }
            .searchable(text: $search)
            .background(Color.red, ignoresSafeAreaEdges: .all)
            .padding()
            .navigationTitle("Bubble List")
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
        .background(Color.red, ignoresSafeAreaEdges: .all)
    }
}

struct ListSection<T>: View where T: Bubble {
    @Binding var search: String
    
    @Environment(\.managedObjectContext) var context
    @Environment(\.colorScheme) var colorScheme
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var bubbles: FetchedResults<T>
    @State var isAdding: Bool = false
    
    var body: some View {
        Section {
            SingleLineTextInput(isEditing: $isAdding, template: "Enter Name") {name in
                let bubble = T(context: context)
                bubble.name = name
                if colorScheme == .dark {
                    bubble.red = Color.randomDarkComponent
                    bubble.green = Color.randomDarkComponent
                    bubble.blue = Color.randomDarkComponent
                }
                else {
                    bubble.red = Color.randomLightComponent
                    bubble.green = Color.randomLightComponent
                    bubble.blue = Color.randomLightComponent
                }
                bubble.notes = ""
            }
            ForEach(bubbles) {b in
                if search.isEmpty || b.name!.lowercased().contains(search.lowercased()) {
                    LinkedBubbleCapsule<T>(bubble: b)
                }
            }
        } header: {
            HeaderView(title: String(describing: T.self), toggle: $isAdding)
        }
        .listRowBackground(Color.background)
    }
}

struct HeaderView : View {
    var title : String
    @Binding var toggle : Bool
    var body : some View {
        HStack {
            Text(title)
            Spacer()
            Button(action: { toggle.toggle() }) {
                Image(systemName: "plus")
            }
        }
    }
}

struct SingleLineTextInput: View {
    @EnvironmentObject var manager: Manager
    @Environment(\.managedObjectContext) var context
    
    @Binding var isEditing: Bool
    var template: String
    var adding: (String) -> Void
    
    @State var text : String = ""
    var body: some View {
        if isEditing {
            TextField(template, text: $text)
                .onSubmit {
                    adding(text)
                    isEditing = false
                    text = ""
                    try? context.save()
                }
        }
    }
}
