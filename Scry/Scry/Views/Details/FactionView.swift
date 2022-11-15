//
//  FactionView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct FactionView: View {
    var faction: Faction
    var body: some View {
        VStack {
            TitleView(bubble: faction)
            Divider()
            Text("Instructor: Name here")
            Divider()
            List {
                Section {

                } header: {
                 
                    HStack {
                        
                        Spacer()
                    }
                }
            }
        }
    }
}
