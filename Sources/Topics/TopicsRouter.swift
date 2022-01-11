//
//  TopicsRouter.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit

public extension Topics {
    /// Topics Router
    struct Router {
        /// Navigation block called when user taps on *Continue* button
        /// Default implementation does nothing
        public var didTapContinue: (UINavigationController) -> () -> Void
    }
}
