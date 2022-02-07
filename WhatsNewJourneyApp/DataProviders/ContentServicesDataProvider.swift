//
//  ContentServicesDataProvider.swift
//  WhatsNewJourneyTestApp
//
//  Created by Backbase R&D B.V. on 07/02/2022.
//

import Foundation
import WhatsNewJourney
import Backbase

final class ContentServicesDataProvider: TopicsUseCase {
    
    private var fileName: String = ""
    private var decoder = JSONDecoder()
    
    /// Initializes a new ContentServicesDataProvider implementing the TopicsUseCase
    /// - Parameter fileName: The name of the remote fiel that contains the topics
    init(fileName: String ) {
        self.fileName = "/" + fileName
    }
    
    func retrieveTopics(completion: @escaping RetrieveTopicsHandler) {
        if !fileName.isEmpty {
            Backbase.content(byPath: fileName, repository: "contentRepository") {content, error in
                
                guard error == nil else {
                    completion(.failure(error!))
                    return
                }
                
                if let data = content!.text?.data(using: .utf8) {
                    
                    do {
                        let topics = try self.decoder.decode([Topic].self, from: data)
                        completion(.success(topics))
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    Backbase.logInfo(self, message: "Unsupported content type")
                }
            }
        }
    }
}
