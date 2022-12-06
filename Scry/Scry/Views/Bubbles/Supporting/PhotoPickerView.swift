//
//  PhotoPickerView.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/22/22.
//

import SwiftUI
import PhotosUI

struct PhotoPickerView: View {
    @State private var selectedItem: PhotosPickerItem? = nil
    @Binding var selection: Data?
    
    var body: some View {
        PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
            HStack {
                Text("Image")
                Spacer()
                if let image = selection {
                    Image(uiImage: UIImage(data: image)!)
                        .resizable()
                        .scaledToFit()
                        .overlay(alignment: .topTrailing) {
                            Image(systemName: "square.grid.2x2")
                        }
                        .frame(width: 50, height: 50)
                }
                else {
                    Image(systemName: "square.grid.2x2")
                        .imageScale(.large)
                        .frame(width: 50, height: 50, alignment: .trailing)
                }
            }
            .foregroundColor(Color(UIColor.label))
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
