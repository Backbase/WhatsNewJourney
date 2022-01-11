//
//  TopicsUseCase.swift
//  WhatsNewJourneySnapshotTests
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import Foundation

/// Conform to this protocol to perform Topics related operations
public protocol TopicsUseCase: AnyObject {
    /// RetrieveTopicsHandler
    typealias RetrieveTopicsHandler = (Result<[Topic], Error>) -> Void
    
    /// Function to retrieve topics
    ///  - Parameter completion: Completion block that will be called with the result of the call
    func retrieveTopics(completion: @escaping RetrieveTopicsHandler)
}
