//
//  FBUAppleAuthenProvider.swift
//  FirebaseAuthUnity
//
//  Created by Ishipo on 6/4/24.
//

import Foundation
import AuthenticationServices
import FirebaseAuth

class FBAppleAuthenProvider: FB3rdAuthenProvider {
    
    override func authorize(_ context: UIViewController?, completed: @escaping (Result<any FTSDK3rdAuthProtocol, FBAError>) -> Void) {
        self.completed = nil
        if #available(iOS 13, *) {
            super.authorize(context, completed: completed)
            let nonce = randomNonceString()
            currentNonce = nonce
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            request.nonce = sha256(nonce)
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.presentationContextProvider = (context as? ASAuthorizationControllerPresentationContextProviding)
            authorizationController.performRequests()
        }
    }
}



extension FBAppleAuthenProvider: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            guard let appleIDToken = appleIDCredential.identityToken else {
                self.completed?(.failure(FBAError(code: 2,
                                                    message: "Unable to fetch identity token")))
                return
            }
            guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
                self.completed?(.failure(FBAError(code: 3,
                                                    message: "Unable to serialize token string from data: \(appleIDToken.debugDescription)")))
                return
            }
            // Initialize a Firebase credential.
            let credential = OAuthProvider.credential(withProviderID: "apple.com",
                                                      idToken: idTokenString,
                                                      rawNonce: currentNonce ?? "")
            
            
            if FBASignIn.isEndableFBA {
                self.signInWithAppAuth(credential, idToken: idTokenString)
            } else {
                let result = FBA3rdResult(idToken: "", authToken: idTokenString)
                self.completed?(.success(result))
            }
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        // Handle error.
        print("Sign in with Apple errored: \(error)")
    }
}
