//
//  TopicRowItem.swift
//  WhatsNewJourneyTestApp
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import Foundation
import BackbaseDesignSystem
import UIKit

/// DTO used to provide information that's visible in the Topics list
public struct TopicRowItem {
    /// DTO that enables providing styleable text on an `TopicRowItem`
    public enum StyleableText {
        /// Plain text with an an attached style.
        case text(String, Style<UILabel>?)
    }
    
    /// DTO that enables providing styleable icon on an `TopicRowItem`
    public enum StyleableIcon {
        /// Material icon with associated style
        case icon(String, Style<IconView>? )
    }
    /// Unique UUID
    public var id = UUID()
    /// Title styleable text
    public let title: StyleableText?
    /// description  styleable text
    public let description: StyleableText?
    /// Icon styleable Icon
    public let icon: StyleableIcon?
}
