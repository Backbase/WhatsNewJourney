//
//  WhatsNewDesignTests.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import XCTest
@testable import WhatsNewJourney

final class WhatsNewDesignTests: XCTestCase {

    func testBackgroundView() throws {
        let testconfig = WhatsNew.Configuration()
        let testBackgroundView = WhatsNew.Design.BackgroundView()
        
        // The initial background color
        testBackgroundView.background = .solid(.blue)
        XCTAssertEqual(testBackgroundView.backgroundColor, .blue)
        
        // Default background view style
        testconfig.design.styles.background(testBackgroundView)
        XCTAssertEqual(testBackgroundView.backgroundColor, testconfig.design.colors.foundation.default)
        
        // A custom background style
        testconfig.design.styles.background = {
            $0.backgroundColor = .green
        }
        
        testconfig.design.styles.background(testBackgroundView)
        XCTAssertEqual(testBackgroundView.backgroundColor, .green)
    }

}
