//
//  Bundle+Extensions.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import Foundation

extension Bundle {
    /// Main Bundle of  `WhatsNew` journey
    static var whatsNew: Bundle? {
        let podBundle = Bundle(for: WhatsNewBundleToken.self)
        guard let resourceUrl = podBundle.url(forResource: "WhatsNewJourneyAssets", withExtension: "bundle"),
              let resourceBundle = Bundle(url: resourceUrl) else {
            return podBundle
        }
        return resourceBundle
    }
}
