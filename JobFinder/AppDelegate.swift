//
//  AppDelegate.swift
//  JobFinder
//
//  Created by Apple on 7/16/20.
//  Copyright © 2020 Apple. All rights reserved.
//

import UIKit
import Firebase
import FirebaseUI
import FirebaseAuth
import GoogleSignIn

@UIApplicationMain class AppDelegate: UIResponder, UIApplicationDelegate, FUIAuthDelegate, GIDSignInDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        //        let authUI = FUIAuth.defaultAuthUI()
        // You need to adopt a FUIAuthDelegate protocol to receive callback
        //        authUI!.delegate = self
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        //"373098498516-ec88qsutjund4ln9e47q9k0ekr8g7f8c.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self
        
        // Do any additional setup after loading the view.
        //        let providers: [FUIAuthProvider] = [FUIGoogleAuth()]
        //        authUI!.providers = providers
        // Override point for customization after application launch.
        return true
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print("Failed to Log into Google", err)
            return
        }
        print("Successfully Logged into Google", user!)
        
        }
        
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url)
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
    
//    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
//
//        let sourceApplication = options[UIApplication.OpenURLOptionsKey.sourceApplication] as! String?
//        if FUIAuth.defaultAuthUI()?.handleOpen(url, sourceApplication: sourceApplication) ?? false {
//            return true
//        }
//        // other URL handling goes here.
//        return false
//    }
}

