//
//  FBASignIn.swift
//  FirebaseAuthUnity
//
//  Created by Ishipo on 6/4/24.
//

import Foundation
import FirebaseCore
import UIKit

@objcMembers
final public class FBASignIn: NSObject {
    public weak var delegate: FBAuthenDelegate?
    
    private static let shared: FBASignIn = FBASignIn()
    
    static public func instance() -> FBASignIn {
        return shared
    }
    
    static public var isEndableFBA: Bool = true
    
    internal private(set) var auth3rdProviders: [FBAuthType: FBU3rdAuthProviderProtocol.Type] = [:]


    public func signIn(with authType: FBAuthType, context: UIViewController) {
        authenWith3rd(context: context, type: authType)
    }
    
    internal func config() {
        invoke(provider: FBGoogleAuthenProvider.self, type: .google)
        invoke(provider: FBAppleAuthenProvider.self, type: .apple)
        invoke(provider: FBFacebookAuthenProvider.self, type: .facebook)
    }
    
    internal func invoke(provider: FBU3rdAuthProviderProtocol.Type, type: FBAuthType) {
        auth3rdProviders[type] = provider
    }
    
}


