//
//  WhatsNewJourneySnapshotTests.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import XCTest
import SnapshotTesting
import Resolver
@testable import WhatsNewJourney

final class WhatsNewJourneySnapshotTests: SnapshotTestCase {
    
    var topics = [Topic]()
    
    override func setUp() {
        Resolver.register { WhatsNew.Configuration() }
        let topic1 = Topic(title: "Check Deposits", description: "Deposit a check with your phone", iconName: "ic_lock_open")
        let topic2 = Topic(title: "Pay bills", description: "Flexibly configure the payment frequency options.", iconName: "ic_assessment")

        topics.append(topic1)
        topics.append(topic2)
    }
    
    func test_TopicsViewSnapshot() {
        if let vc = Topics.build(with: topics) {
            verifySnapshots(withName: "topics-view", for: vc).forEach { XCTFail($0) }
        }
    }
    
}
