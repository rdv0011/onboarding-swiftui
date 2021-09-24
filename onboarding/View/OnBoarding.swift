//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import SwiftUI

struct OnBoarding: View {
    @ObservedObject var viewModel: OnBoardingViewModel

    private var bindableScreenIndex: Binding<Int> {
        Binding(get: { viewModel.screenIndex },
                set: { _ in })
    }

    var body: some View {
        OffsetPageTabView(offset: $viewModel.offset) {
            HStack(spacing: 0) {
                ForEach(viewModel.onBoardingScreensInfo) { screen in
                    VStack(spacing: 15) {
                        Image(screen.image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: screenBounds().width - 100,
                                   height: screenBounds().width - 100)
                            .offset(y: -50)
                        VStack(alignment: .leading, spacing: 12) {
                            Text(screen.title)
                                .font(.largeTitle.bold())
                                .foregroundColor(.white)
                            Text(screen.description)
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .offset(y: -70)
                }
                .padding()
                .frame(width: screenBounds().width)
                .frame(maxWidth: .infinity)
            }
        }
        .background(
            RoundedRectangle(cornerRadius: 50)
                .fill(Color.white)
                .frame(width: screenBounds().width - 100,
                       height: screenBounds().width - 100)
                .scaleEffect(2)
                .rotationEffect(.init(degrees: 25))
                .rotationEffect(.init(degrees: viewModel.backgroundRotation))
                .offset(y: -screenBounds().width + 20)
            , alignment: .leading
        )
        .background(
            viewModel.backgroundColor
        )
        .ignoresSafeArea(.container, edges: .all)
        .overlay(
            VStack {
                HStack(spacing: 25) {
                    CapsuleButton(action: {
                    }, labelText: "Login as iService")
                    CapsuleButton(action: {
                    }, labelText: "SignUp")
                }
                HStack() {
                    SmallButton(action: {
                    }, labelText: "Skip")
                    HStack(spacing: 8) {
                        PageControlCircles(viewModel: PageControlCirclesViewModel(screenIndex: bindableScreenIndex, indices: viewModel.onBoardingScreensInfo.indices))
                    }
                    .frame(maxWidth: .infinity)
                    SmallButton(action: {
                        viewModel.nextButtonPressed()
                    }, labelText: "Next")
                }
                .padding(.top, 25)
                .padding(.horizontal, 8)
            }
            .padding(),
            alignment: .bottom
        )

    }
}

struct OnBoarding_Preview: PreviewProvider {
    static var previews: some View {
        ViewFactory().makeOnBoardingView()
    } 
}
