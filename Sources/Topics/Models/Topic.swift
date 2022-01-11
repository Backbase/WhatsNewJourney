//
//  Topic.swift
//  WhatsNewJourneyTestApp
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import Foundation

/// Topic Item
public struct Topic: Codable {
    /// Topic Title
    public let title: String?
    /// Topic description
    public let description: String?
    /// Topic iconName, following the material icon syntax ic_xxx
    public let iconName: String?
    
    /// Init
    public init(title: String = "", description: String = "", iconName: String = "") {
        self.title = title
        self.description = description
        self.iconName = iconName
    }
}
