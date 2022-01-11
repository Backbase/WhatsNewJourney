//
//  WhatsNewColors.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import BackbaseDesignSystem

public extension WhatsNew.Design {
    /// Colors used in the Journey
    struct Colors {
        /// Create new colors with default values.
        public init() {
            // no code required
        }
        
        /// Foundation Colors.
        public var foundation = Foundation()
        
        /// Surface primary Colors.
        public var surfacePrimary = SurfacePrimary()
        
        /// High contrast colors.
        public var highContrast = HighContrast()
    }
}

// MARK: - Foundation

public extension WhatsNew.Design.Colors {
    /// Foundation Colors.
    struct Foundation {
        /// Create new colors with default values.
        public init() {
            // no code required
        }
        
        /// Light: primary.default, Dark: foundation.default
        public var `default` = UIColor(
            light: DesignSystem.shared.colors.primary.default,
            dark: DesignSystem.shared.colors.foundation.default
        )
        
        /// On foundation primary colors
        public var onFoundation = OnFoundation()
    }
}

public extension WhatsNew.Design.Colors.Foundation {
    /// On foundation colors
    struct OnFoundation {
        /// Create new colors with default values.
        public init() {
            // no code required
        }
        
        /// Any: FFFFFF
        public var `default` = UIColor(any: .white)
    }
}

// MARK: - Surface Primary

public extension WhatsNew.Design.Colors {
    /// Surface primary colors.
    struct SurfacePrimary {
        /// Create new colors with default values
        public init() {
            // no code required
        }
        
        /// Light: surfacePrimary.default, Dark: surfaceDisabled.default.
        public var `default` = UIColor(
            light: DesignSystem.shared.colors.surfacePrimary.default,
            dark: DesignSystem.shared.colors.surfaceDisabled.default
        )
        
        /// On Surface primary colors
        public var onSurfacePrimary = OnSurfacePrimary()
    }
}

public extension WhatsNew.Design.Colors.SurfacePrimary {
    /// On surface primary colors.
    struct OnSurfacePrimary {
        /// Create new colors with default values.
        public init() {
            // no code required
        }
        
        /// Any: onSurfacePrimary.default.
        public var `default` = DesignSystem.shared.colors.surfacePrimary.onSurfacePrimary.default
    }
}

// MARK: - High Contrast

public extension WhatsNew.Design.Colors {
    /// High contrast colors
    struct HighContrast {
        /// Create new colors with default values
        public init() {
            // no code required
        }
        
        /// Light: UIColor.white, Dark: primary.default
        public var primary = UIColor(
            light: .white,
            dark: DesignSystem.shared.colors.primary.default
        )
        
        /// Light: primary.default, Dark: UIColor.white
        public var tint = UIColor(
            light: DesignSystem.shared.colors.primary.default,
            dark: .white
        )
    }
}
