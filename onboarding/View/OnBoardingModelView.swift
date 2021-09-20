//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import Foundation
import UIKit
import SwiftUI

final class OnBoardingViewModel: ObservableObject {
    // Get a screen width from View
    var screenWidth: (()->CGFloat)?
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
        guard let screenWidth = screenWidth?() else {
            fatalError("Expected screen width block is not nil")
        }
        return screenWidth
    }

    private var progress: CGFloat {
        offset / oneScreenOffset
    }
    let onBoardingScreensInfo: [BoardingScreenInformation]

    init(onBoardingScreensInfo: [BoardingScreenInformation]) {
        self.onBoardingScreensInfo = onBoardingScreensInfo
    }

    func nextButtonPressed() {
        let nextValue = offset + oneScreenOffset
        let maxValue = CGFloat(onBoardingScreensInfo.count - 1) * oneScreenOffset
        offset = min(nextValue, maxValue)
    }
}
