//
//  WhatsNewStyles.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import BackbaseDesignSystem

public extension WhatsNew.Design {
    /// Journey Styles
    class Styles {
        internal init(colors: Colors) {
            self.colors = colors
        }
        
        /// Applied to all `BackgroundView` views.
        public lazy var background: Style<WhatsNew.Design.BackgroundView> = { [unowned self] view in
            view.background = .solid(self.colors.foundation.default)
        }
        
        /// Applied to all title labels
        public lazy var title: Style<UILabel> = { [unowned self] label in
            label.numberOfLines = 0
            label.textAlignment = .natural
            label.font = .preferredFont(forTextStyle: .title1, weight: .bold)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = self.colors.foundation.onFoundation.default
        }
        
        /// Applied to all Topic titles
        public lazy var topicTitle: Style<UILabel> = {[unowned self] label in
            label.numberOfLines = 0
            label.textAlignment = .natural
            label.font = .preferredFont(forTextStyle: .subheadline, weight: .semibold)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = self.colors.foundation.onFoundation.default
        }
        
        /// Applied to all topic description 
        public lazy var description: Style<UILabel> = { [unowned self] label in
            label.numberOfLines = 0
            label.textAlignment = .natural
            label.font = .preferredFont(forTextStyle: .caption1)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = self.colors.foundation.onFoundation.default
        }
        
        /// Applied to all subtitles labels.
        public lazy var subtitle: Style<UILabel> = { [unowned self] label in
            label.numberOfLines = 0
            label.textAlignment = .natural
            label.font = .preferredFont(forTextStyle: .caption1)
            label.translatesAutoresizingMaskIntoConstraints = false
            label.textColor = self.colors.foundation.onFoundation.default
        }
        
        /// Applied to all image views.
        public lazy var image: Style<UIImageView> = { [unowned self] image in
            image.contentMode = .scaleAspectFit
            image.tintColor = self.colors.foundation.onFoundation.default
        }
        
        /// Applied to all Icon views.
        public lazy var iconView: Style<IconView> = { [unowned self] icon in
            icon.contentMode = .scaleAspectFit
            icon.tintColor = self.colors.highContrast.tint
            icon.backgroundColor = self.colors.highContrast.primary
            icon.cornerRadius = .medium(roundedCorners: .allCorners)
        }
        
        /// Applied to all Buttons.
        public lazy var button: StyleSelector<WhatsNew.Design.ButtonType, Button> = { [unowned self] type in
            return { button in
                switch type {
                case .primary:
                    DesignSystem.shared.styles.primaryButton(button)
                    button.normalBackgroundColor = self.colors.highContrast.primary
                    button.highlightedBackgroundColor = self.colors.highContrast.primary
                    button.setTitleColor(self.colors.highContrast.tint, for: .normal)
                    button.setTitleColor(self.colors.highContrast.tint, for: .highlighted)
                    button.tintColor = self.colors.highContrast.tint
                case .plain:
                    DesignSystem.shared.styles.linkButton(button)
                    button.setTitleColor(self.colors.foundation.onFoundation.default, for: .normal)
                    button.setTitleColor(self.colors.foundation.onFoundation.default, for: .highlighted)
                    button.tintColor = self.colors.foundation.onFoundation.default
                default:
                    break
                }
                
                DesignSystem.shared.styles.loadingIndicator(button.indicator)
            }
            
        }
        
        // MARK: - Private
        private var colors: Colors
    }
}
