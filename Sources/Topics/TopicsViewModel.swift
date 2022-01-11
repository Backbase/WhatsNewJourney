//
//  TopicsViewModel.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import RxSwift
import RxCocoa
import Resolver

internal final class TopicsViewModel {
    
    init(topics: [Topic]) {
        self.topics = Array(topics.prefix(4))
    }
    
    func bind () ->(
        cancelButtonIcon: Driver<UIImage?>,
        title: Driver<String>,
        continueButtonTitle: Driver<String>
    ) {
        return (
            cancelButtonIcon: .just(configuration.topics.cancelButtonIcon),
            title: .just(configuration.topics.strings.title()) ,
            continueButtonTitle: .just(configuration.topics.strings.continueButtonTitle())
        )
    }
    
    // MARK: - Private
    @LazyInjected
    private var configuration: WhatsNew.Configuration
    private var disposeBag = DisposeBag()
    private(set) var topics: [Topic]
}
