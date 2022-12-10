//
//  ZoomingScrollView.swift
//  Scry
//
//  Created by Stebbins, Daniel Ross on 11/28/22.
//

import SwiftUI

struct ZoomingScrollView<Content>: UIViewRepresentable where Content: View {
    let content: Content
    let zoom: Bool

    init(zoom: Bool, @ViewBuilder content: () -> Content) {
        self.zoom = zoom
        self.content = content()
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        scrollView.delegate = context.coordinator
        scrollView.maximumZoomScale = 10
        scrollView.minimumZoomScale = 1
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor(Color.mapBackground)

        let hostedView = context.coordinator.hostingController.view!
        hostedView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        hostedView.frame = scrollView.bounds
        scrollView.addSubview(hostedView)
        hostedView.backgroundColor = UIColor(Color.mapBackground)
        return scrollView
    }

    func updateUIView(_ uiScrollView: UIScrollView, context: Context) {
        uiScrollView.pinchGestureRecognizer!.isEnabled = zoom
        context.coordinator.hostingController.rootView = self.content
        assert(context.coordinator.hostingController.view.superview == uiScrollView)
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(hostingController: UIHostingController(rootView: content))
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var hostingController: UIHostingController<Content>

        init(hostingController: UIHostingController<Content>) {
            self.hostingController = hostingController
        }

        func viewForZooming(in scrollView: UIScrollView) -> UIView? {
            return hostingController.view
        }
    }
}
