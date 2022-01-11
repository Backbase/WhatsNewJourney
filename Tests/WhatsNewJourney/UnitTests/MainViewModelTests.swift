//
//  MainViewModelTests.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import XCTest
import RxSwift
import RxTest
import Resolver
@testable import WhatsNewJourney

final class MainViewModelTests: XCTestCase {
    
    override class func setUp() {
        super.setUp()
        Resolver.register {WhatsNew.Configuration()}
    }
    
    func testBinding() {
        var config: WhatsNew.Configuration = Resolver.resolve()
        let disposeBag = DisposeBag()
        let scheduler = TestScheduler(initialClock: 0)
        let topics = [Topic]()
        let viewModel = TopicsViewModel(topics: topics)
        
        let output = viewModel.bind()
        
        let title = scheduler.createObserver(String.self)
        output.title.drive(title).disposed(by: disposeBag)
        
        XCTAssertEqual(title.events, [.next(0, config.topics.strings.title()), .completed(0)])
        
        let continueButtonTitle = scheduler.createObserver(String.self)
        output.continueButtonTitle.drive(continueButtonTitle).disposed(by: disposeBag)
        XCTAssertEqual(continueButtonTitle.events, [.next(0, config.topics.strings.continueButtonTitle()), .completed(0)])
    }
    
}
