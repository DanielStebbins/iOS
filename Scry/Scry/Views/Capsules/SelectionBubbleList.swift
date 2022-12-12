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
        GeometryReader { geometry in
            ClosableView {
                ScrollView {
                    let width = geometry.size.width
                    if types.contains(.character) || types.contains(.all) {
                        SelectionListSection<Character>(search: $search, selection: $selection, selected: $selected, excluded: excluded, width: width)
                    }
                    if types.contains(.faction) || types.contains(.all) {
                        SelectionListSection<Faction>(search: $search, selection: $selection, selected: $selected, excluded: excluded, width: width)
                    }
                    if types.contains(.item) || types.contains(.all) {
                        SelectionListSection<Item>(search: $search, selection: $selection, selected: $selected, excluded: excluded, width: width)
                    }
                    if types.contains(.location) || types.contains(.all) {
                        SelectionListSection<Location>(search: $search, selection: $selection, selected: $selected, excluded: excluded, width: width)
                    }
                }
                .searchable(text: $search)
                .padding()
                .navigationTitle("Select a Bubble")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
}

struct SelectionListSection<T>: View where T: Bubble {
    @Binding var search: String
    @Binding var selection: Bubble?
    @Binding var selected: Bool
    let excluded: [UUID]
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
                            selectionRow(bubbles: rows[index], selection: $selection, selected: $selected)
                        }
                    }
                }
                .padding(7)
                .padding(.top, rows.isEmpty ? 20 : 0)
                .overlay {
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.offText, lineWidth: 2)
                }
            } header: {
                HStack {
                    Text(String(describing: T.self))
                }
            }
        }
        .padding(5)
        .padding([.bottom], 10)
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

enum BubbleListSection: String, Identifiable, CaseIterable {
    case character = "Character", faction = "Faction", item = "Item", location = "Location", all = "All"
    var id: RawValue { rawValue }
    
    static func find<T>(type: T.Type) -> BubbleListSection where T: Bubble {
        switch type {
        case is Character.Type: return .character
        case is Faction.Type: return .faction
        case is Item.Type: return .item
        case is Location.Type: return .location
        default: return .character
        }
    }
}

struct selectionRow: View {
    let bubbles: [Bubble]
    @Binding var selection: Bubble?
    @Binding var selected: Bool
    
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        HStack {
            ForEach(bubbles) { b in
                Button(action: { selection = b; selected = true; dismiss() }) {
                    BubbleCapsule(bubble: b)
                }
            }
        }
    }
}
