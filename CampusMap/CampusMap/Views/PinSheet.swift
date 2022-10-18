//
//  PinSheet.swift
//  CampusMap
//
//  Created by Stebbins, Daniel Ross on 10/18/22.
//

import SwiftUI

struct PinSheet: View {
    @EnvironmentObject var manager: Manager
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        let dismissButton = ToolbarItem(placement: .navigationBarTrailing) {
            Button("Dismiss") {
                dismiss()
            }
        }
        
        NavigationStack {
            VStack {
                Image(systemName: "pin")
                    .font(.system(size: 100))
                HStack {
                    Text("Walking Time: \(manager.walkingTime)")
                    Image(systemName: "arrow.right")
                        .foregroundColor(.blue)
                        .rotationEffect(manager.heading(to: manager.selectedPin!.coordinate))
                }
                if(manager.routedPin == manager.selectedPin) {
                    ScrollView {
                        ForEach(manager.route!.steps, id: \.self) { step in
                            Text(step.instructions)
                        }
                    }
                } else {
                    Button("Directions") {
                        manager.routeTo(manager.selectedPin!.coordinate)
                    }
                    .padding(5)
                    .buttonStyle(.borderedProminent)
                    .cornerRadius(10)
                    Spacer()
                }
            }
            .toolbar { dismissButton }
        }
    }
}
