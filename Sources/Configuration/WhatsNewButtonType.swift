//
//  WhatsNewButtonType.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import BackbaseDesignSystem
import SnapKit

extension WhatsNew.Design {
    
    /// An enum representing different type of button styles.
    public enum ButtonType: CaseIterable {
        /// Primary button style.
        case primary
        /// Secondary button style.
        case secondary
        /// Success button style.
        case success
        /// Warning button style.
        case warning
        /// Danger button style.
        case danger
        /// Info button style.
        case info
        /// Plain button style.
        case plain
    }
}

internal extension WhatsNew.Design.ButtonType {
    /// Background color for button style.
    var backgroundColor: UIColor? {
        switch self {
        case .primary:
            return DesignSystem.shared.colors.primary.default
        case .secondary:
            return DesignSystem.shared.colors.secondary.default
        case .success:
            return DesignSystem.shared.colors.success.default
        case .warning:
            return DesignSystem.shared.colors.warning.default
        case .danger:
            return DesignSystem.shared.colors.danger.default
        case .info:
            return DesignSystem.shared.colors.info.default
        case .plain:
            return .clear // User a design system color instead.
        }
    }
    
    /// Tint color for button style.
    var tintColor: UIColor? {
        switch self {
        case .plain:
            return DesignSystem.shared.colors.text.default
        default:
            return DesignSystem.shared.colors.surfacePrimary.default
        }
    }
    
    /// Corner Radius for button style
    var cornerRadius: DesignSystem.CornerRadiusTypes {
        switch self {
        case .plain:
            return DesignSystem.CornerRadiusTypes.none
        default:
            return DesignSystem.CornerRadiusTypes.medium()
        }
    }
    
    /// Content edge insets for button style.
    var contentEdgeInsets: UIEdgeInsets {
        switch self {
        case .plain:
            return .zero
        default:
            return .init(top: 8, left: 16, bottom: 8, right: 16)
        }
    }
}
