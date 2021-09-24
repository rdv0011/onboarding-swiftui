//
// Copyright © 2021 Dmitry Rybakov. All rights reserved.

import UIKit

extension UIColor {
    var components: [CGFloat]? {
        guard let components = self.cgColor.components else {
            return nil
        }

        if components.count == 2 {
            return [components[0],
                    components[0],
                    components[0],
                    components[1]]
        } else {
            return [components[0],
                    components[1],
                    components[2],
                    components[3]]
        }
    }

    // This is a very basic implementation of a color interpolation
    // between two values.
    func interpolate(to color: UIColor, fraction: CGFloat) -> UIColor {
        guard let c1 = components else { return self }
        guard let c2 = color.components else { return color }

        let rgb = zip(c1, c2).map { a, b in
            // Linear interpolation
            CGFloat(a + (b - a) * fraction)
        }

        return UIColor(red: rgb[0], green: rgb[1], blue: rgb[2], alpha: 1.0)
    }
}
