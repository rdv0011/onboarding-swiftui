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
        Int(screenIndexProgress)
    }
    var backgroundColor: Color {
        Color(backgroundColorFrom
                .interpolate(to: backgroundColorTo,
                             fraction: backgroundColorProgress))
    }
    // Background rotation angle in degrees
    var backgroundRotation: Double {
        let progress = screenIndexProgress / 4
        return Double(progress) * 360
    }

    private var colorIndexTo: Int {
        Int(Double(screenIndexProgress).rounded(.up))
    }
    // Background color name to interpolate to
    private var backgroundColorTo: UIColor {
        guard let color = UIColor(named: colorName(by: colorIndexTo)) else {
            return .clear
        }
        return color
    }
    private var colorIndexFrom: Int {
        Int(Float(screenIndexProgress).rounded(.down))
    }
    // Background color name to interpolate from
    private var backgroundColorFrom: UIColor {
        guard let color = UIColor(named: colorName(by: colorIndexFrom)) else {
            return .clear
        }
        return color
    }
    private var backgroundColorProgress: CGFloat {
        screenIndexProgress.truncatingRemainder(dividingBy: 1)
    }

    private var oneScreenWidth: CGFloat {
        guard let screenWidth = screenWidth?() else {
            fatalError("Expected screen width block is not nil")
        }
        return screenWidth
    }

    private var screenIndexProgress: CGFloat {
        max(offset / oneScreenWidth, 0)
    }


    let onBoardingScreensInfo: [BoardingScreenInformation]

    init(onBoardingScreensInfo: [BoardingScreenInformation]) {
        self.onBoardingScreensInfo = onBoardingScreensInfo
    }

    func nextButtonPressed() {
        let nextValue = offset + oneScreenWidth
        let maxValue = CGFloat(onBoardingScreensInfo.count - 1) * oneScreenWidth
        offset = min(nextValue, maxValue)
    }

    private func colorName(by screenIndex: Int) -> String {
        "screen\(screenIndex + 1)"
    }
}
