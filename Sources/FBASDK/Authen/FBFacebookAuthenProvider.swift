//
//  FBUFacebookAuthenProvider.swift
//  FirebaseAuthUnity
//
//  Created by Ishipo on 6/4/24.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit
import FirebaseAuth

class FBFacebookAuthenProvider: FB3rdAuthenProvider {
    
    private var fbLoginManager: LoginManager?
    
    override func authorize(_ context: UIViewController?, completed: @escaping (Result<FTSDK3rdAuthProtocol, FBAError>) -> Void) {
        super.authorize(context, completed: completed)
        if fbLoginManager == nil {
            fbLoginManager = LoginManager()
        }
        fbLoginManager?.logOut()
//        let config = LoginConfiguration(permissions: ["public_profile", "email"])
        fbLoginManager?.logIn(permissions: ["public_profile", "email"],
                              from: context, handler: { [weak self] result, error in
            self?.handleFacebookLoginResult(result, error: error)
        })
    }
    
    private func handleFacebookLoginResult(_ loginResult: LoginManagerLoginResult?, error: Error?) {
        if loginResult?.isCancelled ?? false {
            return
        }
        guard let loginResult = loginResult,
              let tokenString = loginResult.token?.tokenString,
              error == nil else {
            self.completed?(.failure(FBAError(with: error ?? NSError())))
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: tokenString)
        
        if FBASignIn.isEndableFBA {
            self.signInWithAppAuth(credential, idToken: tokenString)
        } else {
            let result = FBA3rdResult(idToken: "", authToken: tokenString)
            self.completed?(.success(result))
        }
    }
}
