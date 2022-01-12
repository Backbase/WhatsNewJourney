//
//  TopicsStrings.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import Foundation
import RetailJourneyCommon

public extension Topics {
    /// Topics Strings
    struct Strings {
        /// Create a new strings object with default values
        public init() {
            // no code required
        }
        
        /// whatsNew.topics.labels.title
        public var title = localized(key: "labels.title")
        
        /// whatsNew.topics.buttons.continue
        public var continueButtonTitle = localized(key: "buttons.continue")
        
        // MARK: - Private
        private static func localized(key: String) -> LocalizedString {
            let prefix = "whatsNew.topics."
            return LocalizedString(key: prefix + key, in: .whatsNew)
        }
    }
}
