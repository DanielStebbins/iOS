//
//  CloseSheet.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 12/10/22.
//

import SwiftUI

struct ClosableView<Content>: View where Content: View {
    let content: () -> Content
    
    @Environment (\.dismiss) private var dismiss
    
    var body: some View {
        let closeButton = ToolbarItem(placement: .navigationBarLeading) {
                Button("Close") {
                    dismiss()
                }
            }
        
        NavigationStack {
            content()
                .toolbar { closeButton }
        }
    }
}
