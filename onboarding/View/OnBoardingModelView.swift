//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import Foundation
import UIKit

final class OnBoardingViewModel: ObservableObject {
    // Get a screen width from View
    var screenWidth: ()->CGFloat
    // Screen offset
    @Published var offset: CGFloat = 0
    // Screen index
    var screenIndex: Int {
        Int(progress)
    }
    // Background color name
    var backgroundColorName: String {
        "screen\(backgroundColorIndex + 1)"
    }
    // Background color based on offset
    var backgroundColorIndex: Int {
        screenIndex
    }
    // Background rotation angle in degrees
    var backgroundRotation: Double {
        let progress = progress / 4
        return Double(progress) * 360
    }

    private var oneScreenOffset: CGFloat {
        screenWidth()
    }

    private var progress: CGFloat {
        offset / oneScreenOffset
    }
    let onBoardingScreensInfo: [BoardingScreenInformation]

    init(onBoardingScreensInfo: [BoardingScreenInformation],
         screenWidth: @escaping () -> CGFloat) {
        self.onBoardingScreensInfo = onBoardingScreensInfo
        self.screenWidth = screenWidth
    }

    // Paging control circle opacity
    func pagingControlCircleOpacity(for index: Int) -> Double {
        index == screenIndex ? 1: 0.8
    }
    func pagingControlCircleScaleEffect(for index: Int) -> CGFloat {
        index == screenIndex ? 1.3: 0.85
    }

    func nextButtonPressed() {
        let nextValue = offset + oneScreenOffset
        let maxValue = CGFloat(onBoardingScreensInfo.count - 1) * oneScreenOffset
        offset = min(nextValue, maxValue)
    }
}
