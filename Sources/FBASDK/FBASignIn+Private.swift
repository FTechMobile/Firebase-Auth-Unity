//
//  FBUSignIn+Private.swift
//  FirebaseAuthUnity
//
//  Created by Ishipo on 6/4/24.
//

import Foundation
import UIKit

extension FBASignIn {

    internal func authenWith3rd(context: UIViewController,
                                type: FBAuthType,
                                onSuccess: @escaping (_ token: String) -> Void,
                                onFailure: @escaping (FBAError) -> Void){
        guard let provider = auth3rdProviders[type]?.init() else {
            onFailure(FBAError(code: 1, message: "Provider not found"))
            return
        }
        
            provider.authorize(context) { [weak self] result in
            switch result {
            case .success(let auth):
                onSuccess(auth.authToken)
            case .failure(let error):
                onFailure(error)
            }
        }
    }
}
