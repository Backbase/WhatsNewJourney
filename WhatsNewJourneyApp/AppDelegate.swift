//
//  AppDelegate.swift
//  WhatsNewTestApp
//
//  Created by Backbase R&D B.V. 11/01/2022
//

import UIKit
import WhatsNewJourney
import Backbase
import RemoteConfig

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appConfiguration: WhatsNew.Configuration?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        initializeBackbase()
        // Override point for customization after application launch.
        window = UIWindow()
        window?.rootViewController = WhatsNewViewController(remoteConfigClient: initializeRemoteConfig())
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
    
    private func initializeRemoteConfig() -> RemoteConfig {
           let r = RemoteConfig.init(serviceUrl: "", projectName: "")
           // Fetch and activate configuration
           r.fetchAndActivate(completion: { status in
               if status {
                   print("Configuration successfully fetched")
               } else {
                   print("Configuration wasn't successfully fetched")
               }
           })
           return r
       }
    
}

