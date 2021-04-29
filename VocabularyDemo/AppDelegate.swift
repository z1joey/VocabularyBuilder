//
//  AppDelegate.swift
//  VocabularyDemo
//
//  Created by Yi Zhang on 2021/4/18.
//  Copyright © 2021 Yi Zhang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let root = DictViewController()
        window?.rootViewController = root
        window?.makeKeyAndVisible()

        return true
    }
}
