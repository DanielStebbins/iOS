//
//  BubbleList.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct BubbleList: View {
    @Environment (\.dismiss) private var dismiss
    
    @State var search: String = ""
    
    var body: some View {
        GeometryReader { geometry in
            ClosableView {

//                List {
                ScrollView {
                    ListCapsuleGrid<Character>(search: $search, width: geometry.size.width)
                    ListCapsuleGrid<Faction>(search: $search, width: geometry.size.width)
                    ListCapsuleGrid<Item>(search: $search, width: geometry.size.width)
                    ListCapsuleGrid<Location>(search: $search, width: geometry.size.width)
                    //                }
                }
                .searchable(text: $search)
                .padding()
                .navigationTitle("Bubble List")
                .navigationBarTitleDisplayMode(.inline)
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
        }
    }
}

//struct ListSection<T>: View where T: Bubble {
//    @Binding var search: String
//
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var bubbles: FetchedResults<T>
//
//    var searchResults: [T] {
//        bubbles.filter({ b in search.isEmpty || b.name!.lowercased().contains(search.lowercased()) }) as [T]
//    }
//
//    var body: some View {
//        Section {
//            ForEach(searchResults) {b in
//                LinkedBubbleCapsule<T>(bubble: b)
//                    .labelStyle(.titleOnly)
//            }
//        } header: {
//            Text(String(describing: T.self))
//        }
//        .listRowBackground(Color.background)
//    }
//}

struct ListCapsuleGrid<T>: View where T: Bubble {
    @Binding var search: String
    let width: CGFloat
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var bubbles: FetchedResults<T>
    
    var searchResults: [T] {
        bubbles.filter({ b in search.isEmpty || b.name!.lowercased().contains(search.lowercased()) }) as [T]
    }
    
    let padding: CGFloat = 17
    
    var body: some View {
        let rows: [[T]] = split()
        
        Section {
            ZStack(alignment: .leading)
            {
                Color.clear
                VStack(alignment: .leading) {
                    ForEach(Array(rows.enumerated()), id: \.element) { index, element in
                        CapsuleRow(bubbles: rows[index])
                    }
                }
            }
            .padding(7)
            .padding(.top, rows.isEmpty ? 30 : 0)
            .overlay {
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 2)
            }
        } header: {
            HStack {
                Text(String(describing: T.self))
                ListBubbleAdder()
            }
        }
        .listRowBackground(Color.background)
    }
    
    func split() -> [[T]] {
        let sortedBubbles = searchResults.sorted(by: { $0.name! < $1.name! })
        
        var count: CGFloat = 0.0
        var rows: [[T]] = []
        var row: [T] = []
        for bubble in sortedBubbles {
            let textWidth: CGFloat = bubble.name!.size(withAttributes: [.font: UIFont.systemFont(ofSize: 20)]).width
            if count + textWidth + 30 + padding > width {
                rows.append(row)
                row = []
                count = 0.0
            }
            row.append(bubble)
            count += textWidth + 30 + padding
        }
        if !row.isEmpty {
            rows.append(row)
        }
        return rows
    }
}

struct ListBubbleAdder<T>: View where T: Bubble {
    @State var selection: Bubble?
    @State var selected: Bool = false
    @State var showAddSheet: Bool = false
    
    var body : some View {
        Button(action: { showAddSheet = true }) {
            Image(systemName: "plus")
                .imageScale(.large)
        }
        .sheet(isPresented: $showAddSheet) {
            NewBubbleSheet(selectedBubble: $selection, added: $selected)
        }
    }
}
