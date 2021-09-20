//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import SwiftUI

/// Embeds scroll view with paging enabled which looks like horizontally sliding pages
/// Content is supposed to define more than one ```View```
struct OffsetPageTabView<Content: View>: UIViewRepresentable {
    // Binding for offset of Paging Control
    @Binding var offset: CGFloat
    var content: Content

    init(offset: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self._offset = offset
        self.content = content()
    }

    func makeCoordinator() -> Coordinator {
        OffsetPageTabView.Coordinator(self)
    }

    func makeUIView(context: Context) -> UIScrollView {
        let scrollView = UIScrollView()
        let hostView = UIHostingController(rootView: content)
        hostView.view.translatesAutoresizingMaskIntoConstraints = false
        hostView.view.backgroundColor = .clear
        scrollView.addSubview(hostView.view)
        NSLayoutConstraint.activate([
            hostView.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            hostView.view.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            hostView.view.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            hostView.view.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            hostView.view.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
        scrollView.isPagingEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.delegate = context.coordinator

        return scrollView
    }

    /// Update content offset if ```offset``` variable is changed from outside(when some button is pressed)
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        let currentOffset = uiView.contentOffset.x
        if currentOffset != offset {
            uiView.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        }
    }

    class Coordinator: NSObject, UIScrollViewDelegate {
        var parent: OffsetPageTabView

        init(_ parent: OffsetPageTabView) {
            self.parent = parent
        }

        /// Track an offset changes and update ```offset``` correspondingly
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            parent.offset = scrollView.contentOffset.x
        }
    }
}
