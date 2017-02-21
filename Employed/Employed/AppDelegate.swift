//
//  AppDelegate.swift
//  Employed
//
//  Created by Jermaine Kelly on 2/17/17.
//  Copyright © 2017 Employed Inc. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rollingLogo: UIImageView?
    var customizedLaunchScreenView: UIView?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        
        //Styling
        UILabel.appearance().font = UIFont(name: "Avenir Next", size: 11.0)
        
        
        //Setup Windows
        FIRApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        
        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent
        let navigationBarAppearace = UINavigationBar.appearance()
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
        navigationBarAppearace.barTintColor = Colors.darkPrimaryColor
        
        let tabBarAppearnce = UITabBar.appearance()
        tabBarAppearnce.barTintColor = UIColor.white
        tabBarAppearnce.tintColor = UIColor.red
        //
        let loginVC = LoginViewController()
        
        let rootTabController = UITabBarController()
        let jobSearchVC = JobSearchViewController()
        let searchResultsTVC = SearchResultsTableViewController()
        let searchDetailVC = SearchDetailViewController()
        let savesTVC = SavesTableViewController()
        let profileTVC = LoginViewController()
        
        let jobSearchTabItem = UITabBarItem(title: "search", image: #imageLiteral(resourceName: "search"), tag: 0)
        let savesTabItem = UITabBarItem(title: "saves", image: #imageLiteral(resourceName: "save"), tag: 1)
        let profileTabItem = UITabBarItem(title: "profile", image: #imageLiteral(resourceName: "user"), tag: 2)
        
        jobSearchVC.tabBarItem = jobSearchTabItem
        savesTVC.tabBarItem = savesTabItem
        profileTVC.tabBarItem = profileTabItem
        
        
        
        let jobSearchNavController = UINavigationController(rootViewController: jobSearchVC)
        let savesNavController = UINavigationController(rootViewController: savesTVC)
        let profileNavController = UINavigationController(rootViewController: profileTVC)
        rootTabController.viewControllers = [jobSearchNavController, savesNavController, profileNavController]
        
        
        window?.rootViewController = rootTabController
        //window?.rootViewController = jobSearchVC
        window?.makeKeyAndVisible()
        
        
        
        
        
        
        
        
        
        if let window = self.window {
            self.customizedLaunchScreenView = UIView(frame: window.bounds)
            self.customizedLaunchScreenView?.backgroundColor = Colors.backgroundColor
            
            self.window?.addSubview(self.customizedLaunchScreenView!)
            self.window?.bringSubview(toFront: self.customizedLaunchScreenView!)
            
            self.rollingLogo = UIImageView(frame: .zero)
            self.rollingLogo?.image = #imageLiteral(resourceName: "logo")
            
            self.window?.addSubview(rollingLogo!)
            self.window?.bringSubview(toFront: rollingLogo!)
            
            self.rollingLogo?.snp.makeConstraints{ (view) in
                view.centerY.equalTo(window.snp.centerY).offset(10)
                view.centerX.equalTo(window.snp.centerX)
            }
    
            
            let duration = 3.0
            let delay = 0.0
            let options = UIViewKeyframeAnimationOptions.calculationModeLinear
            
            UIView.animateKeyframes(withDuration: duration, delay: delay, options: options, animations: {
                // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
                
                
            
                UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration:  1/2 , animations: {
                    self.rollingLogo?.transform = CGAffineTransform(scaleX: 2, y: 2)

                })

                UIView.addKeyframe(withRelativeStartTime: 1/2, relativeDuration: 1/2, animations: {
                    self.rollingLogo?.transform = CGAffineTransform(scaleX: 1, y: 1)
                })

                
            }, completion: { finished in
                // any code entered here will be applied
                // once the animation has completed
                
                UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseOut,
                               animations: { () -> Void in
                                self.rollingLogo?.transform = CGAffineTransform(translationX: 0, y: -1000)
                                self.customizedLaunchScreenView?.alpha = 0
                                
                                
                },
                               completion: {_ in
                                
                                _ = [
                                    self.customizedLaunchScreenView,
                                    self.rollingLogo
                                    ].map { $0?.removeFromSuperview() }
                })
            })
        }
        
        
        
        
        
        
        
        
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


}

