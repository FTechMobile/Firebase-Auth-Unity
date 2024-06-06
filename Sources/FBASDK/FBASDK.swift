//
//  FBASDK.swift
//
//
//  Created by Ishipo on 6/6/24.
//

import UIKit
import Firebase
import FBSDKCoreKit
import GoogleSignIn


public class FBASDK: NSObject {
    @objc public static func didFinishLaunching(_ application: UIApplication, with launchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        FirebaseApp.configure()
        FBASignIn.instance().config()
    }
    
    @discardableResult
    @objc public static func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]?) -> Bool {
     
        let source = options?[UIApplication.OpenURLOptionsKey.sourceApplication] as? String
        let annotation = options?[UIApplication.OpenURLOptionsKey.annotation]
        let handleFB = ApplicationDelegate.shared.application(app,open: url, sourceApplication: source, annotation: annotation)
        if handleFB {
            return handleFB
        }
        let handleGG = GIDSignIn.sharedInstance.handle(url)
        if handleGG {
            return handleGG
        }
        return false
    }
    
    @discardableResult
    @objc public static func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
     
        let handleFB = ApplicationDelegate.shared.application(application,open: url,
                                                              sourceApplication: sourceApplication,
                                                              annotation: annotation)
        if handleFB {
            return handleFB
        }
        let handleGG = GIDSignIn.sharedInstance.handle(url)
        if handleGG {
            return handleGG
        }
        return false
    }
    
}
