//
//  TopicsDesign.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit

public extension Topics {
    /// Topics Screen design-related configurations
    struct Design {
        internal init(journeyDesign: WhatsNew.Design) {
            self.journeyDesign = journeyDesign
        }
        /// Applied to all `BackgroundView` views.
        public lazy var background = journeyDesign.styles.background
        
        /// Applied to all title labels in the Topics screens
        public lazy var title = journeyDesign.styles.title
        
        /// Applied to all subtitle labels in the Topics screens
        public lazy var subtitle = journeyDesign.styles.subtitle
        
        /// Applied to the continue button in the Topics screens
        public lazy var continueButton = journeyDesign.styles.button(.primary)
        
        /// Applied to the cancel button in the Topics Screen
        public lazy var cancelButton = journeyDesign.styles.button(.plain)
        
        /// Topic Title
        public lazy var topicTitle = journeyDesign.styles.topicTitle
        
        /// Topic Subtitle
        public lazy var topicDescription = journeyDesign.styles.subtitle
        
        /// Topic Icon
        public lazy var topicIcon = journeyDesign.styles.iconView
        
        // MARK: - Private
        private let journeyDesign: WhatsNew.Design
    }
}
