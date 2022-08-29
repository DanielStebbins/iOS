//
//  SubmitButtonView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct SubmitButtonView: View {
    var body: some View {
        Button(action: {}) {
            Text("Submit")
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .buttonStyle(.borderedProminent)
        .cornerRadius(10)
    }
}

struct SubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButtonView()
    }
}
