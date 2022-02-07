//
//  RemoteConfigDataProvider.swift
//  WhatsNewJourneyTestApp
//
//  Created by Backbase R&D B.V. on 07/02/2022.
//

import Foundation
import Backbase
import RemoteConfig
import WhatsNewJourney

final class RemoteConfigDataProvider: TopicsUseCase {
    
    private var remoteConfigClient: RemoteConfig
    private var jsonDecoder = JSONDecoder()
    
    init(client: RemoteConfig) {
        self.remoteConfigClient = client
    }
    
    /// Retreive Topics from the RemoteConfig since
    /// - Parameter completion: RetrieveTopicsHandler
    func retrieveTopics(completion: @escaping RetrieveTopicsHandler) {
        
        if let topics = remoteConfigClient.getDictionary(name: "sampleTopics"), !topics.isEmpty {
            if let tpc = topics.first{
                do {
                    let jsonData: Data = try JSONSerialization.data(withJSONObject: tpc.value, options: [])
                    let tpcs = try self.jsonDecoder.decode([Topic].self, from: jsonData)
                    completion(.success(tpcs))
                } catch let error {
                    completion(.failure(error))
                }
            }
        } else {
            Backbase.logInfo(self, message: "No topics were found")
        }
    }
}
