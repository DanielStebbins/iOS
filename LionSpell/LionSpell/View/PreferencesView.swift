//
//  PreferencesView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 9/12/22.
//

import SwiftUI

struct PreferencesView: View {
    @Binding var preferences: Preferences
    @Environment (\.dismiss) private var dismiss
    var body: some View {
        Form {
            Section(header: Text("Difficulty Level")) {
                Picker("Difficulty", selection: $preferences.difficulty) {
                    ForEach(Difficulty.allCases) {
                        Text(String($0.rawValue)).tag($0)
                    }
                } .pickerStyle(.segmented)
            }
            
            Section(header: Text("Language")) {
                Picker("Language", selection: $preferences.language) {
                    ForEach(Language.allCases) {
                        Text($0.rawValue.capitalized).tag($0)
                    }
                } .pickerStyle(.segmented)
            }
            
            Button("Dismiss") {
                dismiss()
            }
        }
    }
}

struct PreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        PreferencesView(preferences: .constant(Preferences()))
    }
}
