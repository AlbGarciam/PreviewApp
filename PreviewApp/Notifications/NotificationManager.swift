//
//  NotificationManager.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 03/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit
import UserNotifications

struct NotificationManager {
    static func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { (access, error) in
            print("Permission granted: \(access)")
        }
    }
    
    static func throwPayloadNotification() {
        let content = UNMutableNotificationContent()
        content.title = NSString.localizedUserNotificationString(forKey: "Hey Buddy!", arguments: nil)
        content.body = NSString.localizedUserNotificationString(forKey: "You have new videos to watch", arguments: nil)
        content.sound = UNNotificationSound.default
        let notification = UNNotificationRequest(identifier: "New videos", content: content, trigger: nil)
        let center = UNUserNotificationCenter.current()
        center.add(notification, withCompletionHandler: nil)
    }
    
    static func payloadNotificationAction(payload: Payload) {
        let application = UIApplication.shared
        switch application.applicationState {
        case .active:
            let playerScreen = application.keyWindow?.rootViewController as? PlayerScreenViewController
            playerScreen?.viewModel.loadVideos()
        default:
            throwPayloadNotification()
        }
    }
    
    static func handleNotification(notification: JSON, completion: @escaping (UIBackgroundFetchResult) -> Void) {
        if let payload = Payload(json: notification) {
            AssetRepository.fetch(payload: payload) {
                payloadNotificationAction(payload: payload)
                completion(.newData)
            }
        } else {
            completion(.noData)
        }
    }
}
