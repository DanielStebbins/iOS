//
//  MapView.swift
//  Scry
//
//  Created by Thomas Stebbins on 11/23/22.
//

// If the PDF view doesn't work for some reason in the future, try this UIKit solution:
// https://stackoverflow.com/questions/58341820/isnt-there-an-easy-way-to-pinch-to-zoom-in-an-image-in-swiftui

import SwiftUI
import PDFKit

struct MapView: View {
    @ObservedObject var map: Map
    var body: some View {
        PhotoDetailView(image: map.image != nil ? UIImage(data: map.image!)! : UIImage(imageLiteralResourceName: "square-grid"))
    }
}

struct PhotoDetailView: UIViewRepresentable {
    let image: UIImage

    func makeUIView(context: Context) -> PDFView {
        let view = PDFView()
        view.document = PDFDocument()
        guard let page = PDFPage(image: image) else { return view }
        view.document?.insert(page, at: 0)
        view.autoScales = true
        return view
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        // empty
    }
}
