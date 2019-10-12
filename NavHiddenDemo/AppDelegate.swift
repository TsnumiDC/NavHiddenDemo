//
//  AppDelegate.swift
//  NavHiddenDemo
//
//  Created by Dylan Chen on 2019/10/11.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let nav = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = nav
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        window?.backgroundColor = UIColor.white
        return true
    }

}

