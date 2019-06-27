//
//  AppDelegate.swift
//  DependencyInjection
//
//  Created by Alfian Losari on 27/06/19.
//  Copyright © 2019 Alfian Losari. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        let tabController = UITabBarController()
        let gameService = GameStore.shared
        
        let controllers = Platform.allCases.map { (platform) -> UIViewController in
            let gameVC = GameListViewController(gameService: gameService, platform: platform)
            gameVC.title = platform.description
            gameVC.tabBarItem = UITabBarItem(title: platform.description, image: UIImage(named: platform.assetName), tag: platform.rawValue)
            return UINavigationController(rootViewController: gameVC)
        }
        
        tabController.setViewControllers(controllers, animated: false)
        window.rootViewController = tabController
        window.makeKeyAndVisible()
        self.window = window
        return true
    }


}

