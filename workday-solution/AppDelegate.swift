//
//  AppDelegate.swift
//  workday-solution
//
//  Created by Clinton Buie on 4/6/18.
//  Copyright © 2018 AmateMint. All rights reserved.
//

import UIKit
import PromiseKit
import Reachability
import NotificationBannerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var reachability:Reachability = Reachability()!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //declare this property where it won't go out of scope relative to your listener
        self.setupReachability()
        return true
    }
    
    private func setupReachability() {
        //declare this inside of viewWillAppear
        
        NotificationCenter.default.addObserver(self, selector: #selector(reachabilityChanged(note:)), name: .reachabilityChanged, object: reachability)
        do {
            try reachability.startNotifier()
        } catch {
            let banner = StatusBarNotificationBanner(title: error.localizedDescription, style: .warning)
            banner.show()
            print("could not start reachability notifier")
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

extension AppDelegate {
    
    class func getAppDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    func setRootViewController(_ controller:UIViewController) {
        self.window?.rootViewController = controller
        self.window?.makeKeyAndVisible()
    }
    
    @objc func reachabilityChanged(note: Notification) {
        
        DispatchQueue.main.async {
            let reachability = note.object as! Reachability
            switch reachability.connection {
            case .wifi:
                print("Reachable via WiFi")
                let banner = StatusBarNotificationBanner(title: "Wifi Connected", style: .success)
                banner.show()
            case .cellular:
                print("Reachable via Cellular")
                let banner = StatusBarNotificationBanner(title: "Cell only Connection", style: .info)
                banner.show()
            case .none:
                print("Network not reachable")
                let banner = StatusBarNotificationBanner(title: "No Internet Connection", style: .danger)
                banner.show()
            }
        }
    }
}

