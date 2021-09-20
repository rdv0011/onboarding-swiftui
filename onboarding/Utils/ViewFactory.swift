//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import Foundation

final class ViewFactory {
    let imageNames = ["screen1",
                       "screen2",
                       "screen3",
                       "screen4"]
    let titles = ["Easy payments with \nWallettory",
                  "Free cash withdrawing \nWallettory",
                  "Cache back with \nWallettory",
                  "Special bonuses with \nWallettory"]
    let descriptions = ["Small business can receive \npayment fast and super easy",
                        "In any place in the world \nfast and free withdrawing",
                        "Receive you money back \nto make more purchases",
                        "More freedom and choses \nwith special bonuses"]

    lazy var boardingScreens: [BoardingScreenInformation] = [
        BoardingScreenInformation(image: imageNames[0], title: titles[0], description: descriptions[0]),
        BoardingScreenInformation(image: imageNames[1], title: titles[1], description: descriptions[1]),
        BoardingScreenInformation(image: imageNames[2], title: titles[2], description: descriptions[2]),
        BoardingScreenInformation(image: imageNames[3], title: titles[3], description: descriptions[3])
    ]

    func makeOnBoardingView() -> OnBoarding {
        let viewModel = OnBoardingViewModel(onBoardingScreensInfo: boardingScreens)
        let view = OnBoarding(viewModel: viewModel)
        viewModel.screenWidth =  {
            view.screenBounds().width
        }
        return view
    }
}
