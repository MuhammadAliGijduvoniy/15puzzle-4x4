//
//  AppDelegate.swift
//  15puzzle 4x4
//
//  Created by MuhammadAli on 19/12/23.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = MainVC()
        window?.makeKeyAndVisible()

        return true
    }

 


}

