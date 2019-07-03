//
//  AppDelegate.swift
//  PreviewApp
//
//  Created by Alberto García-Muñoz on 01/07/2019.
//  Copyright © 2019 SoundApp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        let data = Utilities.loadJSON(bundle: Bundle(for: type(of: self)), from: "SamplePayload")
//        do {
//            let payload = try JSONDecoder().decode(Payload.self, from: data!)
//            AssetRepository.fetch(payload: payload)
//        } catch {
//            fatalError(error.localizedDescription)
//        }
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = PlayerScreenRouter.getViewController()
        window!.backgroundColor = .black
        window!.makeKeyAndVisible()
        return true
    }
    
    
}

