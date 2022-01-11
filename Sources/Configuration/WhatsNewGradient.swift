//
//  WhatsNewGradient.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit

extension WhatsNew.Design {
    /// Represents a gradient
    public struct Gradient {
        /// Can be used for start of end points in a gradient.
        public struct Point {
            /// Point where color is applied (values between `(x: 0, y: 0)` and `(x: 1, y: 1)`).
            /// - `(x: 0, y: 0)`: top left
            /// - `(x: 1, y: 0)`: top right
            /// - `(x: 0, y: 1)`: bottom left
            /// - `(x: 1, y: 1)`: bottom right
            public let point: CGPoint

            /// Color to be applied in point.
            public let color: UIColor

            /// Create a new point.
            /// - Parameters:
            ///   - point: Point where color is applied.
            ///   - color: Color to be applied in point.
            public init(point: CGPoint, color: UIColor) {
                self.point = point
                self.color = color
            }
        }
        
        /// Can be used to set colors between start and end points.
        public struct Location {
            /// Location where color is applied (values between `0` and `1`).
            /// - eg. `0.5` will set the color in the middle of the gradient.
            public let location: CGFloat

            /// Color to be applied in location.
            public let color: UIColor

            /// Create a new location
            /// - Parameters:
            ///   - location: Location where color is applied (values between `0` and `1`).
            ///   - color: Color to be applied in location.
            public init(location: CGFloat, color: UIColor) {
                self.location = location
                self.color = color
            }
        }
        
        /// Gradient start point.
        public let startPoint: Point

        /// Gradient end point.
        public let endPoint: Point

        /// Gradient locations.
        public let locations: [Location]

        /// Create a new gradient.
        /// - Parameters:
        ///   - startPoint: Gradient start point.
        ///   - endPoint: Gradient end point.
        ///   - locations: Gradient locations (default is `[]`).
        public init(startPoint: Point, endPoint: Point, locations: [Location] = []) {
            self.startPoint = startPoint
            self.endPoint = endPoint
            self.locations = locations
        }
    }
    
    internal final class GradientView: UIView {
        override class var layerClass: AnyClass {
            return CAGradientLayer.classForCoder()
        }
        
        override var bounds: CGRect {
            didSet {
                gradientLayer?.frame = bounds
            }
        }
        
        override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
            super.traitCollectionDidChange(previousTraitCollection)
            guard let currentGradient = gradient else { return }
            if #available(iOS 13, *), traitCollection.hasDifferentColorAppearance(comparedTo: previousTraitCollection) {
                gradient = currentGradient
            }
        }
        
        var gradientLayer: CAGradientLayer? {
            return layer as? CAGradientLayer
        }
        
        var gradient: Gradient? {
            didSet {
                guard let gradient = gradient else {
                    gradientLayer?.colors = nil
                    gradientLayer?.locations = nil
                    return
                }
                
                gradientLayer?.startPoint = gradient.startPoint.point
                gradientLayer?.endPoint = gradient.endPoint.point
                
                let color = [gradient.startPoint.color.cgColor] +
                    gradient.locations.map(\.color.cgColor) +
                    [gradient.endPoint.color.cgColor]
                gradientLayer?.colors = color
                
                let locations = [0] + gradient.locations.map(\.location) +
                    [1]
                
                gradientLayer?.locations = locations as [NSNumber]
                
            }
        }
    }
}
