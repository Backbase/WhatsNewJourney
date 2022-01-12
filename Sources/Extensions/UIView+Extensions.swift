//
//  UIView+Extensions.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit

extension UIView {
    /// Adds multiple views to the end of the receiver's list of subviews.
    /// - Parameter subviews: The list of views to be added. After being added, this new views appears on top of any other subviews.
    func addSubviews(_ subviews: UIView...) {
        subviews.forEach(addSubview(_:))
    }
}
