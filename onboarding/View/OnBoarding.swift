//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import SwiftUI

struct OnBoarding: View {
    @ObservedObject var viewModel: OnBoardingViewModel

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
                            .offset(y: -80)
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
            Color(viewModel.backgroundColorName)
                .animation(.easeInOut, value: viewModel.backgroundColorIndex)
        )
        .ignoresSafeArea(.container, edges: .all)
        .overlay(
            VStack {
                HStack(spacing: 25) {
                    Button {

                    } label: {
                        Text("Login as iService")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .clipShape(Capsule())
                    }
                    Button {

                    } label: {
                        Text("SignUp")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                            .offset(x: -5)
                            .padding(.vertical, 20)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .clipShape(Capsule())
                    }
                }
                HStack() {
                    Button {

                    } label: {
                        Text("Skip")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
                    HStack(spacing: 8) {
                        ForEach(viewModel.onBoardingScreensInfo.indices, id: \.self) { index in
                            Circle()
                                .fill(Color.white)
                                .opacity(viewModel.pagingControlCircleOpacity(for: index))
                                .frame(width: 8, height: 8)
                                .scaleEffect(viewModel.pagingControlCircleScaleEffect(for: index))
                                .animation(.easeOut, value: viewModel.screenIndex)
                        }
                    }
                    .frame(maxWidth: .infinity)
                    Button {
                        viewModel.nextButtonPressed()
                    } label: {
                        Text("Next")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                    }
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
