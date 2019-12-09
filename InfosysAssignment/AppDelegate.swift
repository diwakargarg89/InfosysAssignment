//
//  AppDelegate.swift
//  InfosysAssignment
//
//  Created by Diwakar Garg on 09/12/2019.
//  Copyright © 2019 Diwakar Garg. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Check network connection
        networkConnectionCheck()
        //set the base view controller
        setDefaultView()
        return true
    }
    //Set the Default View 
    func setDefaultView()
    {
        window = UIWindow(frame:UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: TableViewController())
        window?.makeKeyAndVisible()
    }
    //CheckNetworkConnectionStatus
    func networkConnectionCheck()
    {
        do {
                   try Network.reachability = Reachability(hostname: "www.google.com")
               }
               catch {
                   switch error as? Network.Error {
                   case let .failedToCreateWith(hostname)?:
                       print("Network error:\nFailed to create reachability object With host named:", hostname)
                   case let .failedToInitializeWith(address)?:
                       print("Network error:\nFailed to initialize reachability object With address:", address)
                   case .failedToSetCallout?:
                       print("Network error:\nFailed to set callout")
                   case .failedToSetDispatchQueue?:
                       print("Network error:\nFailed to set DispatchQueue")
                   case .none:
                       print(error)
                   }
               }
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
    

}

