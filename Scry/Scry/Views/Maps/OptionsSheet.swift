//
//  OptionsSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct OptionsSheet: View {
    @ObservedObject var map: Map
    
    @EnvironmentObject var manager: Manager
    @Environment(\.managedObjectContext) var context
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Name", text: Binding($map.name)!)
                    .multilineTextAlignment(.center)
                    .bold()
                    .italic()
                    .font(.headline)
                PhotoPickerView(selection: $map.image)
            }
            .toolbar { DismissButton(dismiss: dismiss).toolbarItem }
            .toolbar { DeleteButton(dismiss: dismiss, deleteAction: { context.delete(map); manager.selectedMap = nil }).toolbarItem }
        }
    }
}
