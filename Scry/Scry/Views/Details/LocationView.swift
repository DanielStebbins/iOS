//
//  LocationView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/15/22.
//

import SwiftUI

struct LocationView: View {
    var location: Location
    var body: some View {
        VStack {
            TitleView(bubble: location)
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
