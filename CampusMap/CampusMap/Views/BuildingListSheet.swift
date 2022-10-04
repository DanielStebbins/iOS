//
//  BuildingList.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/2/22.
//

import SwiftUI

struct BuildingListSheet: View {
    @EnvironmentObject var manager: Manager
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button("Dismiss") {
                dismiss()
            }
        }
        
        NavigationStack {
            List {
                ForEach($manager.model.buildings) { $building in
                    BuildingRow(building: $building)
                }
            }
            .toolbar {
                dismissButton
            }
        }
    }
}

struct BuildingRow: View {
    @EnvironmentObject var manager: Manager
    @Binding var building: Building
    
    var body: some View {
        Button(action: { building.isShown = !building.isShown! }) {
            HStack {
                Text(building.name)
                Spacer()
                Image(systemName: "eye")
                    .opacity(building.isShown! ? 1.0 : 0.0)
            }
        }
    }
}

struct BuildingListSheet_Previews: PreviewProvider {
    static var previews: some View {
        BuildingListSheet()
    }
}
