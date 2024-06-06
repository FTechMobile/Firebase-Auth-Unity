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
                                type: FBAuthType) {
        guard let provider = auth3rdProviders[type]?.init() else {
            delegate?.onFBASDKError?(error: FBAError(code: 1, message: "Provider not found"))
            return
        }
        
            provider.authorize(context) { [weak self] result in
            switch result {
            case .success(let auth):
                self?.delegate?.onLoginSuccess?(token: auth.authToken, withMethod: type.rawValue)
            case .failure(let error):
                self?.delegate?.onLoginFailed?(with: error)
            }
        }
    }
}
