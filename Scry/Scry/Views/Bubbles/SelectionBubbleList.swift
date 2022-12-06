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
    
    @Environment (\.dismiss) private var dismiss
    
    @State var search: String = ""
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        
        NavigationStack {
            List {
                SelectionListSection<Character>(search: $search, selection: $selection, selected: $selected)
                SelectionListSection<Faction>(search: $search, selection: $selection, selected: $selected)
                SelectionListSection<Item>(search: $search, selection: $selection, selected: $selected)
                SelectionListSection<Location>(search: $search, selection: $selection, selected: $selected)
            }
            .searchable(text: $search)
            .padding()
            .navigationTitle("Select a Bubble")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar { dismissButton }
        }
    }
}

struct SelectionListSection<T>: View where T: Bubble {
    @Binding var search: String
    @Binding var selection: Bubble?
    @Binding var selected: Bool
    
    @Environment (\.dismiss) private var dismiss
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var bubbles: FetchedResults<T>
    
    var searchResults: [T] {
        bubbles.filter({ b in search.isEmpty || b.name!.lowercased().contains(search.lowercased()) }) as [T]
    }
    
    var body: some View {
        Section {
            ForEach(searchResults) {b in
                Button(action: { selection = b; selected = true; dismiss() }) {
                    BubbleCapsule(bubble: b)
                        .labelStyle(.titleOnly)
                }
            }
        } header: {
            Text(String(describing: T.self))
        }
        .listRowBackground(Color.background)
    }
}

