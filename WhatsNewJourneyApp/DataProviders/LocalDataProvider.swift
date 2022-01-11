//
//  LocalDataProvider.swift
//  WhatsNewJourneyTestApp
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import Foundation
import WhatsNewJourney
import Backbase

final class LocalDataProvider: TopicsUseCase {
    private let decoder = JSONDecoder()
    private var fileName = ""
    private var ofType = ""
    
    /// Initializes a new LocalDataProvider implementing the TopicsUseCase
    /// - Parameters:
    ///   - fileName: The name of the local file that contains the topics
    ///   - ofType: The extension of the local file. Defaults to "json"
    init(fileName: String, ofType: String = "json") {
        self.fileName = fileName
        self.ofType = ofType
    }
    
    func retrieveTopics(completion: @escaping RetrieveTopicsHandler) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: ofType) else {
            Backbase.logInfo(self, message: "Can not find file \(fileName)")
            return
        }
        
        let fileUrl = URL(fileURLWithPath: filePath)
        if let data = try? Data(contentsOf: fileUrl, options: .uncached), let tpcs = try? self.decoder.decode([Topic].self, from: data) {
            completion(.success(tpcs))
        } else {
            Backbase.logInfo(self, message: "Unable to decode contents of the file.")
        }
    }
}
