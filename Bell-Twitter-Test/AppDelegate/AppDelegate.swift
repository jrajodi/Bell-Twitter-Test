//
//  AppDelegate.swift
//  Bell-Twitter-Test
//
//  Created by Jigs on 2019-09-28.
//  Copyright © 2019 Jignesh Rajodiya. All rights reserved.
//

import UIKit
import TwitterKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setupTwitterSettings()
        return true
    }
}

// MARK: - Helper Methods
extension AppDelegate {
    private func setupTwitterSettings() {
        TWTRTwitter.sharedInstance().start(withConsumerKey:TwitterKeys.consumerKey, consumerSecret:TwitterKeys.consumerSecret)
    }
}
