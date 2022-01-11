//
//  WhatsNewConfiguration.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import Foundation

public extension WhatsNew {
    /// WhatsNew journey configurations.
    struct Configuration {
        /// Create a new configuration object with default values
        public init() {
            // no code required
        }
        
        /// Main Screen Configuration
        public lazy var topics = Topics.Configuration(journeyDesign: design)

        /// Journey configurations.
        public var design = Design()
        
    }
}
