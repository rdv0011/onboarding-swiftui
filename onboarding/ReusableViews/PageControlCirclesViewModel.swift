//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import SwiftUI

final class PageControlCirclesViewModel: ObservableObject {
    @Binding var screenIndex: Int
    var indices: Range<Int>

    init(screenIndex: Binding<Int>, indices: Range<Int>) {
        self._screenIndex = screenIndex
        self.indices = indices
    }

    func pagingControlCircleOpacity(for index: Int) -> Double {
        index == screenIndex ? 1: 0.8
    }

    func pagingControlCircleScaleEffect(for index: Int) -> CGFloat {
        index == screenIndex ? 1.3: 0.85
    }
}
