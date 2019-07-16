//
//  AppDelegate.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit
import os.log

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificationHandler.requestPermission()
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = PlayerScreenRouter.getViewController()
        window!.backgroundColor = .black
        window!.makeKeyAndVisible()
        application.registerForRemoteNotifications()
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        let playerScreen = application.keyWindow?.rootViewController as? PlayerScreenViewController
        playerScreen?.viewModel.loadVideos()
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        os_log("Remote notification = %@", userInfo)
        guard let notification = userInfo as? JSON else { return completionHandler(.noData) }
        NotificationHandler.handleNotification(notification: notification, completion: completionHandler)
    }
    
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenString = deviceToken.reduce("", {$0 + String(format: "%02X", $1)})
        os_log("Device Token: %@", tokenString) // Once backend is ready, send token to a backend
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        os_log("Remote notification register failed = %@", error.localizedDescription)
    }
}
