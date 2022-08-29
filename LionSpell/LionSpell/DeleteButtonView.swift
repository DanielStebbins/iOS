//
//  DeleteButtonView.swift
//  LionSpell
//
//  Created by Stebbins, Daniel Ross on 8/29/22.
//

import SwiftUI

struct DeleteButtonView: View {
    var body: some View {
        Button("Delete", role: .destructive, action: {})
    }
}

struct DeleteButtonView_Previews: PreviewProvider {
    static var previews: some View {
        DeleteButtonView()
    }
}
