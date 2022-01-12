//
//  MainViewController.swift
//  WhatsNewJourney
//
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import XCTest
import UIKit
import Resolver
@testable import WhatsNewJourney

final class MainViewControllerTests: XCTestCase {
    override class func setUp() {
        super.setUp()
        Resolver.register {WhatsNew.Configuration() }
    }
    
    func test_assertNil_WithEmptyTopics(){
        let topics = [Topic]()
        let vc = Topics.build(with: topics)
        XCTAssertNil(vc)
    }
    
    func test_assertFalse_ViewHasSomeLayout() throws{
        var topics = [Topic]()
        let topic1 = Topic(title: "", description: "", iconName: "")
        topics.append(topic1)
        
        if let viewcontroller = Topics.build(with: topics) {
            XCTAssertFalse(viewcontroller.view.constraints.isEmpty, "The view should have some constraints applied")
        }
    }
}
