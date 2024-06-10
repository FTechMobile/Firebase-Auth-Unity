//
//  FBUGoogleAuthenProvider.swift
//  FirebaseAuthUnity
//
//  Created by Ishipo on 6/4/24.
//

import Foundation
import UIKit
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

class FBGoogleAuthenProvider: FB3rdAuthenProvider {
    
    override func authorize(_ context: UIViewController?, completed: @escaping (Result<FTSDK3rdAuthProtocol, FBAError>) -> Void) {
        super.authorize(context, completed: completed)
        guard let context = context else { return }
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
                
        let config = GIDConfiguration(clientID: clientID)

        GIDSignIn.sharedInstance.configuration = config


        GIDSignIn.sharedInstance.signIn(withPresenting: context) { authentication, error in
            if let code = (error as? NSError)?.code, code == GIDSignInError.canceled.rawValue {
                return
            }
            if let error = error {
                self.completed?(.failure(FBAError(with: error)))
                return
            }
            
            guard
                let user = authentication?.user,
                let idToken = user.idToken?.tokenString
            else {
                return
            }
            
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
            
            if FBASignIn.isEndableFBA {
                self.signInWithAppAuth(credential, idToken: idToken)
            } else {
                let result = FBA3rdResult(idToken: idToken, authToken: user.accessToken.tokenString)
                self.completed?(.success(result))
            }
        }
    }
    
    override func signOut() {
        GIDSignIn.sharedInstance.signOut()
        super.signOut()
    }
}
