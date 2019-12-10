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
        //Check network connection
        networkConnectionCheck()
        //set the base view controller
        setDefaultView()
        return true
    }
    //Set the Default View 
    func setDefaultView() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: TableViewController())
        window?.makeKeyAndVisible()
    }
    //CheckNetworkConnectionStatus
    func networkConnectionCheck() {
        do {
                   try Network.reachability = Reachability(hostname: "www.google.com")
               } catch {
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

       }
       
       func applicationDidEnterBackground(_ application: UIApplication) {
          
        }
       
       func applicationWillEnterForeground(_ application: UIApplication) {
           
       }
       
       func applicationDidBecomeActive(_ application: UIApplication) {
           
       }
       
       func applicationWillTerminate(_ application: UIApplication) {
          
       }

}
