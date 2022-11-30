//
//  ZoomingScrollView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

// Referenced jtbandes post for the idea to use a UIScrollView for the map.
// https://stackoverflow.com/questions/58341820/isnt-there-an-easy-way-to-pinch-to-zoom-in-an-image-in-swiftui

import SwiftUI

struct ZoomingScrollView<T>: UIViewRepresentable where T: View {
    let content: T

    init(@ViewBuilder content: () -> T) {
        self.content = content()
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 10
        scrollView.minimumZoomScale = 1
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        let hostedView = context.coordinator.hostingController.view!
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        return scrollView
    }

    func updateUIView(_ uiScrollView: UIScrollView, context: Context) {
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiScrollView)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: content))
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<T>

        init(hostingController: UIHostingController<T>) {
            self.hostingController = hostingController
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}