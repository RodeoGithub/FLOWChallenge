//
//  AppDelegate.swift
//  FLOWChallenge
//
//  Created by Rodrigo Maidana on 14/09/2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        let standardUserDefaults = UserDefaults.standard
        
        if !standardUserDefaults.bool(forKey: K.UserDefaultsKey.hasLaunchedOnce) {
            standardUserDefaults.set(true, forKey: K.UserDefaultsKey.hasLaunchedOnce)
            standardUserDefaults.set(K.unit, forKey: K.UserDefaultsKey.preferedUnits)
            standardUserDefaults.set(K.buenosAiresCoord, forKey: K.UserDefaultsKey.lastLocation)
            standardUserDefaults.set("", forKey: K.UserDefaultsKey.lastDescription)
            standardUserDefaults.set("", forKey: K.UserDefaultsKey.lastTemperature)
            standardUserDefaults.set("cloud.sun", forKey: K.UserDefaultsKey.lastIcon)
            standardUserDefaults.set("Buenos Aires", forKey: K.UserDefaultsKey.lastCityName)
            
            standardUserDefaults.synchronize()
        }
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

