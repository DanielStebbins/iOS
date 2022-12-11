//
//  SelectionBubbleList.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/5/22.
//

import SwiftUI

struct SelectionBubbleList: View {
    @Binding var selection: Bubble?
    @Binding var selected: Bool
    let types: [BubbleListSection]
    var excluded: [UUID] = []
    
    @Environment (\.dismiss) private var dismiss
    
    @State var search: String = ""
    
    var body: some View {
        List {
            if types.contains(.none) || types.contains(.all) {
                Button(action: { selection = nil; selected = true; dismiss() }) {
                    Text("None")
                }
            }
            if types.contains(.character) || types.contains(.all) {
                SelectionListSection<Character>(search: $search, selection: $selection, selected: $selected, excluded: excluded)
            }
            if types.contains(.faction) || types.contains(.all) {
                SelectionListSection<Faction>(search: $search, selection: $selection, selected: $selected, excluded: excluded)
            }
            if types.contains(.item) || types.contains(.all) {
                SelectionListSection<Item>(search: $search, selection: $selection, selected: $selected, excluded: excluded)
            }
            if types.contains(.location) || types.contains(.all) {
                SelectionListSection<Location>(search: $search, selection: $selection, selected: $selected, excluded: excluded)
            }
        }
        .searchable(text: $search)
        .padding()
        .navigationTitle("Select a Bubble")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SelectionListSection<T>: View where T: Bubble {
    @Binding var search: String
    @Binding var selection: Bubble?
    @Binding var selected: Bool
    let excluded: [UUID]
    
    @Environment (\.dismiss) private var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var bubbles: FetchedResults<T>
    
    var searchResults: [T] {
        bubbles.filter({ b in search.isEmpty || b.name!.lowercased().contains(search.lowercased()) }) as [T]
    }
    
    var body: some View {
        Section {
            ForEach(searchResults) {b in
                if !excluded.contains(b.uuid!) {
                    Button(action: { selection = b; selected = true; dismiss() }) {
                        BubbleCapsule(bubble: b)
                            .labelStyle(.titleOnly)
                    }
                }
            }
        } header: {
            Text(String(describing: T.self))
        }
        .listRowBackground(Color.background)
    }
}

enum BubbleListSection: String, Identifiable, CaseIterable {
    case character = "Character", faction = "Faction", item = "Item", location = "Location", none = "None", all = "All"
    var id: RawValue { rawValue }
    
    static func find<T>(type: T.Type) -> BubbleListSection where T: Bubble {
        switch type {
        case is Character.Type: return .character
        case is Faction.Type: return .faction
        case is Item.Type: return .item
        case is Location.Type: return .location
        default: return .none
        }
    }
}
