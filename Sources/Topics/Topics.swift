//
//  Topics.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import Resolver
import Backbase

/// Topics - This represent a generic topic
public struct Topics {
   /// Entry point for the `Topics` screen, will display upto 4 topics
    public static func build(with topics: [Topic]) -> UIViewController? {
        let viewModel = TopicsViewModel(topics: topics)
       
        if !topics.isEmpty {
            let viewController = TopicsViewController()
            viewController.bind(viewModel: viewModel)
            return viewController
        } else {
            Backbase.logInfo(self, message: "No topics provided")
            return nil
        }
    }
}
