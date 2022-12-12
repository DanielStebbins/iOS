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
        GeometryReader { geometry in
            ClosableView {
                ScrollView {
                    let width = geometry.size.width
                    ListCapsuleGrid<Character>(search: $search, width: width)
                    ListCapsuleGrid<Faction>(search: $search, width: width)
                    ListCapsuleGrid<Item>(search: $search, width: width)
                    ListCapsuleGrid<Location>(search: $search, width: width)
                }
                .background(Color.listBackground)
                .searchable(text: $search)
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

struct ListCapsuleGrid<T>: View where T: Bubble {
    @Binding var search: String
    let width: CGFloat
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var bubbles: FetchedResults<T>
    
    var searchResults: [T] {
        bubbles.filter({ b in search.isEmpty || b.name!.lowercased().contains(search.lowercased()) }) as [T]
    }
    
    let padding: CGFloat = 25
    
    var body: some View {
        let rows: [[T]] = split()
        
        VStack(alignment: .leading) {
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
                .padding(.top, rows.isEmpty ? Constants.capsuleSize : 0)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.offText, lineWidth: 2)
                }
            } header: {
                HStack {
                    Text(String(describing: T.self))
                    ListBubbleAdder<T>()
                }
            }
        }
        .padding(15)
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
        Button(action: { showAddSheet = true; print(BubbleType(type: T.self))}) {
            Image(systemName: "plus")
                .imageScale(.large)
        }
        .sheet(isPresented: $showAddSheet) {
            NewBubbleSheet(selectedBubble: $selection, added: $selected, types: [BubbleType(type: T.self)])
                .presentationDetents([.fraction(0.2)])
        }
    }
}
