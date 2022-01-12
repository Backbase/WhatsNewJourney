//
//  WhatsNewDesign.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import BackbaseDesignSystem

public extension WhatsNew {
    /// Journey design-related configurations.
    class Design {
        /// Colors.
        public var colors = Colors()
        
        /// Styles
        public lazy var styles = Styles(colors: colors)
    }
}
