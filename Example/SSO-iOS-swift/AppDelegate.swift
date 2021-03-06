//
//  AppDelegate.swift
//  SSO-iOS-swift
//
//  Created by CI-Hank.Chien on 2020/2/19.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

import UIKit
import CISSO

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        SSOManager.shared().facebookDataSource(dataSource: self)
        SSOManager.shared().lineDataSource(dataSource: self)
        SSOManager.shared().googleDataSource(dataSource: self)
        SSOManager.shared().setConfig(application: application, launchOptions: launchOptions, dataSource: self)
//        ThirdPartyLoginManager.share.facebookDataSource(dataSource: self)
//        ThirdPartyLoginManager.share.lineDataSource(dataSource: self)
//        ThirdPartyLoginManager.share.googleDataSource(dataSource: self)
//        ThirdPartyLoginManager.share.setConfig(application: application, launchOptions: launchOptions, dataSource: self)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {


        
        return SSOManager.shared().handleOpenUrl(app: app, url: url, options: options)


    }
    
//    func application(
//        _ application: UIApplication,
//        continue userActivity: NSUserActivity,
//        restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool
//    {
//        if LoginManager.shared.application(application, open: userActivity.webpageURL) {
//            return true
//        }
//        return true
//        // Your other code to handle universal links and/or user activities.
//    }
}


extension AppDelegate: LineDataSource{
    var lineChannel: String {
        return "1653849381"
    }
}

extension AppDelegate: GoogleDataSource{
    var googleAppID: String {
        return "919405796658-0vc2qr4qi9bookf52uf26tlsgc7h2lal.apps.googleusercontent.com"
    }
}

extension AppDelegate: FacebookDataSource{
    var facebookAppID: String {
        return "186438775778435"
    }

    var facebookDisplayName: String {
        return "Cloud-interactive login"
    }
}

