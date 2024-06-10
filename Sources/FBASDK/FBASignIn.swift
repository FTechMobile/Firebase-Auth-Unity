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
    
    private static let shared: FBASignIn = FBASignIn()
    
    static public func instance() -> FBASignIn {
        return shared
    }
    
    public static var versionNumber: String  = "1.0.1"

    static internal var isEndableFBA: Bool = true
    
    
    internal private(set) var auth3rdProviders: [FBAuthType: FBU3rdAuthProviderProtocol.Type] = [:]
    
    public func loginWithGoogle(context: UIViewController,
                                onSuccess: @escaping (_ token: String) -> Void,
                         onFailure: @escaping (FBAError) -> Void) {
        FBASignIn.isEndableFBA = true
        authenWith3rd(context: context, type: .google, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    public func loginWithFacebook(context: UIViewController,
                         onSuccess: @escaping (_ token: String) -> Void,
                         onFailure: @escaping (FBAError) -> Void) {
        FBASignIn.isEndableFBA = true
        authenWith3rd(context: context, type: .facebook, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    public func loginWithApple(context: UIViewController,
                         onSuccess: @escaping (_ token: String) -> Void,
                         onFailure: @escaping (FBAError) -> Void) {
        FBASignIn.isEndableFBA = true
        authenWith3rd(context: context, type: .apple, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    public func loginWithGoogleWithoutFirebase(context: UIViewController,
                         onSuccess: @escaping (_ token: String) -> Void,
                         onFailure: @escaping (FBAError) -> Void) {
        FBASignIn.isEndableFBA = false
        authenWith3rd(context: context, type: .google, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    public func loginWithFacebookWithoutFirebase(context: UIViewController,
                         onSuccess: @escaping (_ token: String) -> Void,
                         onFailure: @escaping (FBAError) -> Void) {
        FBASignIn.isEndableFBA = false
        authenWith3rd(context: context, type: .facebook, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    public func loginWithAppleWithoutFirebase(context: UIViewController,
                         onSuccess: @escaping (_ token: String) -> Void,
                         onFailure: @escaping (FBAError) -> Void) {
        FBASignIn.isEndableFBA = false
        authenWith3rd(context: context, type: .apple, onSuccess: onSuccess, onFailure: onFailure)
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




