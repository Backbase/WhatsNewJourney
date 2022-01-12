//
//  WhatsNewButtonTypeTests.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import XCTest
import BackbaseDesignSystem
@testable import WhatsNewJourney

internal final class WhatsNewButtonTypeTests: XCTestCase {
    func testBackgroundColor(){
        let colors = DesignSystem.shared.colors
        for type in WhatsNew.Design.ButtonType.allCases {
            switch type {
            case .primary:
                XCTAssertEqual(type.backgroundColor, colors.primary.default)
            case .secondary:
                XCTAssertEqual(type.backgroundColor, colors.secondary.default)
            case .success:
                XCTAssertEqual(type.backgroundColor, colors.success.default)
            case .warning:
                XCTAssertEqual(type.backgroundColor, colors.warning.default)
            case .danger:
                XCTAssertEqual(type.backgroundColor, colors.danger.default)
            case .info:
                XCTAssertEqual(type.backgroundColor, colors.info.default)
            case .plain:
                XCTAssertEqual(type.backgroundColor, .clear)
            }
        }
    }
}
