//
//  LocalizableStringsTests.swift
//  WhatsNewJourney
//
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import XCTest
import RetailJourneyCommon
@testable import WhatsNewJourney

final class LocalizableStringsTests: XCTestCase {

    func testStrings() {
        XCTAssertEqual(localized(key: "topics.labels.title")(), "What's New")
        XCTAssertEqual(localized(key: "topics.buttons.continue")(), "Continue")
    }
    // MARK: - Private
    private func localized(key: String) -> LocalizedString {
        let prefix = "whatsNew."
        return LocalizedString(key: prefix + key, in: .whatsNew)
    }
}
