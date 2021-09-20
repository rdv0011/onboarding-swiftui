//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import SwiftUI

struct SmallButton: View {
    let action: () -> Void
    let labelText: String

    var body: some View {
        Button(action: action, label: {
            Text(labelText)
                .fontWeight(.semibold)
                .foregroundColor(.white)
        })
    }
}

struct CapsuleButton: View {
    let action: () -> Void
    let labelText: String

    var body: some View {
        Button(action: action, label: {
            Text(labelText)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .padding(.vertical, 20)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(Capsule())
        })
    }
}
