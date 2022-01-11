//
//  AppDelegate.swift
//  WhatsNewTestApp
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import WhatsNewJourney
import Backbase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appConfiguration: WhatsNew.Configuration?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeBackbase()
        // Override point for customization after application launch.
        window = UIWindow()
        window?.rootViewController = WhatsNewViewController()
        window?.makeKeyAndVisible()
                
        return true
    }
    
    private func initializeBackbase() {
        do {
            try Backbase.initialize("config.json", forceDecryption: false)
        } catch {
            fatalError("Backbase MSDK initialization failed: \(error.localizedDescription)")
        }
    }
    
}

