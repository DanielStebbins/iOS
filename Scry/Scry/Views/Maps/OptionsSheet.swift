//
//  OptionsSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct OptionsSheet: View {
    @ObservedObject var map: Map
    @Binding var newMap: Bool
    
    @EnvironmentObject var manager: Manager
    @Environment(\.managedObjectContext) var context
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
                Button("Dismiss") {
                    dismiss()
                }
            }
        
        let deleteButton = ToolbarItem(placement: .navigationBarLeading) {
            Button(action: { dismiss(); context.delete(map); newMap = true }) {
                Image(systemName: "trash")
                    .imageScale(.large)
            }
        }
        
        NavigationStack {
            VStack {
                TextField("Name", text: Binding($map.name)!)
                    .multilineTextAlignment(.center)
                    .bold()
                    .italic()
                    .font(.headline)
                PhotoPickerView(selection: $map.image)
            }
            .toolbar { dismissButton }
            .toolbar { deleteButton}
        }
    }
}
