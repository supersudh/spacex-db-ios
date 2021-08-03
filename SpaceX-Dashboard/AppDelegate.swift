//
//  AppDelegate.swift
//  SpaceX-Dashboard
//
//  Created by Sudharsan Ravikumar on 02/08/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        self.window = UIWindow(frame: UIScreen.main.bounds)
        manageFirstScreen()
        return true
    }

    // MARK: UISceneSession Lifecycle

//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }
    
    func manageFirstScreen() {
        // if logged in show movie screen else show signin screen
        let loggedInUserName = AppUserDefaults.value(forKey: .loggedInUserName, fallBackValue: "").stringValue
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        if loggedInUserName != "" {
            // show movie screen
            let drawerVC = mainStoryboard.instantiateViewController(identifier: "drawerContainer")
            let nav = UINavigationController(rootViewController: drawerVC)
            nav.isNavigationBarHidden = true
            self.window?.rootViewController = nav
            self.window?.makeKeyAndVisible()
        } else {
            let logInScreen = mainStoryboard.instantiateViewController(identifier: "ViewController")
            let nav = UINavigationController(rootViewController: logInScreen)
            nav.isNavigationBarHidden = true
            self.window?.rootViewController = logInScreen
            self.window?.makeKeyAndVisible()
        }
    }


}

