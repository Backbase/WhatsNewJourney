//
//  TopicsConfiguration.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import BackbaseDesignSystem
import Resolver

public extension Topics {
    /// Configuration
    struct Configuration {
        internal init(journeyDesign: WhatsNew.Design) {
            self.journeyDesign = journeyDesign
        }
        
        /// Topics design configuration
        public lazy var design = Design(journeyDesign: journeyDesign)
        
        /// Cancel button icon(default: `UIImage.named("ic_close",in .main, .design)`
        public var cancelButtonIcon = UIImage.named(DesignSystem.Assets.icClose, in: .main, .design)
        
        /// Topics Strings
        public var strings = Strings()
        
        /// Router configuration for `Topics` screen
        public var router = Router { navigationControler in
            return { 
                navigationControler.dismiss(animated: true)
            }
        }
        
        /// Configuration that returns a `TopicRowItem` for a specific `Topic`
        public var topicsRowProvider: (Topic) -> TopicRowItem = { topic in
            var configuration = Resolver.resolve(WhatsNew.Configuration.self)
            let title: TopicRowItem.StyleableText?
            let description: TopicRowItem.StyleableText?
            let icon: TopicRowItem.StyleableIcon?
            
            if let topicTitle = topic.title {
                title = .text(topicTitle, {
                    configuration.topics.design.topicTitle($0)
                })
            } else {
                title = .text("", nil)
            }
            
            if let topicDescription = topic.description {
                description = .text(topicDescription, {
                    configuration.topics.design.topicDescription($0)
                })
            } else {
                description = .text("", nil)
            }
            
            if let topicIcon = topic.iconName {
                icon = .icon(topicIcon, {
                    configuration.topics.design.topicIcon($0)
                })
            } else {
                icon = .icon(DesignSystem.Assets.icAssignment, {
                    configuration.topics.design.topicIcon($0)
                })
            }
            
            return TopicRowItem(title: title, description: description, icon: icon)
        }
        
        // MARK: - Private
        private let journeyDesign: WhatsNew.Design
    }
}
