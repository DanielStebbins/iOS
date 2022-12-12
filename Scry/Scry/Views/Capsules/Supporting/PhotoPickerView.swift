//
//  PhotoPickerView.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/22/22.
//

import SwiftUI
import PhotosUI

// Stylized SwiftUI PhotosPicker.
struct PhotoPickerView: View {
    let title: String
    @Binding var selection: Data?
    
    @State private var selectedItem: PhotosPickerItem? = nil
    
    let size = Constants.photoPickerPictureSize
    
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
                    
                    // Small circular picture of the current picture.
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size, alignment: .trailing)
                        .clipped()
                        .cornerRadius(size / 2)
                }
                else {
                    Image(systemName: "square.grid.2x2")
                        .imageScale(.large)
                        .frame(width: size, height: size, alignment: .trailing)
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
