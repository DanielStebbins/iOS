//
//  SubmitButtonView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

// Displays the submit button.
struct SubmitButtonView: View {
    @EnvironmentObject var gameManager : GameManager
    var body: some View {
        Button(action: gameManager.submitButtonPress) {
            Text("Submit")
                .font(.largeTitle)
                .frame(maxWidth: .infinity)
        }
        .padding()
        .buttonStyle(.borderedProminent)
        .cornerRadius(10)
        .disabled(gameManager.submitButtonDisabled)
    }
}

struct SubmitButtonView_Previews: PreviewProvider {
    static var previews: some View {
        SubmitButtonView()
    }
}
