//
//  FBUAuthDelegate.swift
//  FirebaseAuthUnity
//
//  Created by Ishipo on 6/4/24.
//

import Foundation

@objc public protocol FBAuthenDelegate: AnyObject {
    @objc optional func onFBASDKError(error: FBAError)
    @objc optional func onLoginSuccess(token: String, withMethod authType: String)
    @objc optional func onLoginFailed(with error: FBAError)
}
