
//
//  SnapshotTestCase.swift
//  WhatsNewJourney
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import XCTest
import SnapshotTesting

class SnapshotTestCase: XCTestCase {
    override class func setUp() {
        super.setUp()

        // SnapshotTesting.isRecording = true
    }

    final func verifySnapshots(withName name: String, for controller: UIViewController,
                               renderingTime: TimeInterval = 0.1, timeout: TimeInterval = 10, file: StaticString = #file) -> [String] {

        UIView.setAnimationsEnabled(false)

        // finish appearanceTransition before assertions
        controller.beginAppearanceTransition(true, animated: false)
        controller.endAppearanceTransition()

        var  devices: [(ViewImageConfig, String)] = [
            (.iPhone8(.portrait, .light), "iphone8-light"),
            (.iPhoneX(.portrait, .light), "iphone-x-light"),
            (.iPhoneSe(.portrait, .light), "iphone-se-light"),
            (.iPhoneXr(.portrait, .light), "iphone-xr-light")
        ]

        if #available(iOS 13.0, *) {
            devices += [
                (.iPhone8(.portrait, .dark), "iphone8-dark"),
                (.iPhoneX(.portrait, .dark), "iphone-x-dark"),
                (.iPhoneXr(.portrait, .dark), "iphone-xr-dark"),
                (.iPhoneSe(.portrait, .dark), "iphone-se-dark")
            ]
        }

        return devices.compactMap { verifySnapshot(matching: controller, as: .wait(for: renderingTime, on: .image(on: $0.0)),
                                                   named: "\($0.1)-\(osVersion)", timeout: timeout, file: file, testName: name) }
    }

    private lazy var osVersion: String = {
        let os: String
        #if os(OSX)
        os = "macOS"
        #elseif os(watchOS)
        os = "watchOS"
        #elseif os(tvOS)
        os = "tvOS"
        #elseif os(iOS)
        #if targetEnvironment(macCatalyst)
        os = "macOS - Catalyst"
        #else
        os = "iOS"
        #endif
        #endif

        return os+"\(ProcessInfo().operatingSystemVersion.majorVersion)"
    }()
}

extension UITraitCollection {
    static func iPhone8(_ orientation: ViewImageConfig.Orientation, _ style: ViewImageConfig.InterfaceStyle)
        -> UITraitCollection {
            let userInterfaceStyle: UIUserInterfaceStyle
            switch style {
            case .light:
                userInterfaceStyle = .light
            case .dark:
                userInterfaceStyle = .dark
            }
            let traitCollection = UITraitCollection(userInterfaceStyle: userInterfaceStyle)
            return UITraitCollection(traitsFrom: [iPhone8(orientation), traitCollection])
    }

    static func iPhoneX(_ orientation: ViewImageConfig.Orientation, _ style: ViewImageConfig.InterfaceStyle)
        -> UITraitCollection {
            let userInterfaceStyle: UIUserInterfaceStyle
            switch style {
            case .light:
                userInterfaceStyle = .light
            case .dark:
                userInterfaceStyle = .dark
            }
            let traitCollection = UITraitCollection(userInterfaceStyle: userInterfaceStyle)
            return UITraitCollection(traitsFrom: [iPhoneX(orientation), traitCollection])
    }

    static func iPhoneXr(_ orientation: ViewImageConfig.Orientation, _ style: ViewImageConfig.InterfaceStyle)
        -> UITraitCollection {
            let userInterfaceStyle: UIUserInterfaceStyle
            switch style {
            case .light:
                userInterfaceStyle = .light
            case .dark:
                userInterfaceStyle = .dark
            }
            let traitCollection = UITraitCollection(userInterfaceStyle: userInterfaceStyle)
            return UITraitCollection(traitsFrom: [iPhoneXr(orientation), traitCollection])
    }
    
    static func iPhoneSe(_ orientation: ViewImageConfig.Orientation, _ style: ViewImageConfig.InterfaceStyle)
        -> UITraitCollection {
            let userInterfaceStyle: UIUserInterfaceStyle
            switch style {
            case .light:
                userInterfaceStyle = .light
            case .dark:
                userInterfaceStyle = .dark
            }
            let traitCollection = UITraitCollection(userInterfaceStyle: userInterfaceStyle)
            return UITraitCollection(traitsFrom: [iPhoneSe(orientation), traitCollection])
    }
}

extension ViewImageConfig {
    enum InterfaceStyle {
      case light
      case dark

      @available(iOS 12.0, *) var userInterfaceStyle: UIUserInterfaceStyle {
        switch self {
          case .light: return .light
          case .dark: return .dark
        }
      }
    }

    static func iPhone8(_ orientation: Orientation, _ style: InterfaceStyle = .light) -> ViewImageConfig {
        let config = iPhone8(orientation)
        return ViewImageConfig(safeArea: config.safeArea, size: config.size, traits: .iPhone8(orientation, style))
    }

    static func iPhoneX(_ orientation: Orientation, _ style: InterfaceStyle = .light) -> ViewImageConfig {
        let config = iPhoneX(orientation)
        return ViewImageConfig(safeArea: config.safeArea, size: config.size, traits: .iPhoneX(orientation, style))
    }

    static func iPhoneXr(_ orientation: Orientation, _ style: InterfaceStyle = .light) -> ViewImageConfig {
        let config = iPhoneXsMax(orientation)
        return ViewImageConfig(safeArea: config.safeArea, size: config.size, traits: .iPhoneXr(orientation, style))
    }
    
    static func iPhoneSe(_ orientation: Orientation, _ style: InterfaceStyle = .light) -> ViewImageConfig {
        let config = iPhoneSe(orientation)
        return ViewImageConfig(safeArea: config.safeArea, size: config.size, traits: .iPhoneSe(orientation, style))
    }
}
