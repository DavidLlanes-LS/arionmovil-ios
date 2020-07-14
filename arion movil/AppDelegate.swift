//
//  AppDelegate.swift
//  arion movil
//
//  Created by David Pacheco Rodriguez on 02/07/20.
//  Copyright © 2020 David Pacheco Rodriguez. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Exo-Bold", size: 16)!]
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Exo-Bold", size: 32)!]
        UITableViewCell.appearance().backgroundColor = UIColor.init(named: "background")
        UINavigationBar.appearance().backgroundColor = UIColor.init(named: "background")
        UITableView.appearance().backgroundColor = UIColor.init(named: "background")
        UITabBar.appearance().backgroundColor = UIColor.init(named: "background")
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

