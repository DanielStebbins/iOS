//
//  PhotoPickerView.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/22/22.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    let title: String
    @Binding var selection: Data?
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
            HStack {
                Text(title)
                    .foregroundColor(.white)
                Spacer()
                if let image = selection {
                    Button(role: .destructive, action: { selection = nil }) {
                        Image(systemName: "trash")
                    }
                    
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipped()
                        .cornerRadius(20)
                }
                else {
                    Image(systemName: "square.grid.2x2")
                        .imageScale(.large)
                        .frame(width: 30, height: 30, alignment: .trailing)
                        .foregroundColor(.white)
                }
            }
        }
        .onChange(of: selectedItem) {newItem in
            Task {
                if let data = try? await newItem?.loadTransferable(type: Data.self) {
                    selection = data
                }
            }
        }
    }
}
