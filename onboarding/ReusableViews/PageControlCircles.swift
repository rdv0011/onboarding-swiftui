//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import SwiftUI

struct PageControlCircles: View {
    @ObservedObject var viewModel: PageControlCirclesViewModel

    var body: some View {
        ForEach(viewModel.indices, id: \.self) { index in
            Circle()
                .fill(Color.white)
                .opacity(viewModel.pagingControlCircleOpacity(for: index))
                .frame(width: 8, height: 8)
                .scaleEffect(viewModel.pagingControlCircleScaleEffect(for: index))
                .animation(.easeOut, value: viewModel.screenIndex)
        }
    }
}
