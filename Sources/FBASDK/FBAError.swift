//
//  FBUError.swift
//  FirebaseAuthUnity
//
//  Created by Ishipo on 6/4/24.
//

import Foundation

@objcMembers
public class FBAError: NSError {
    internal static let FTechDomain = "ai.ftech.FBUSDK"
    
    
    
    public init(with error: Error) {
        let error = error as NSError
        
        super.init(domain: error.domain, code: error.code, userInfo: error.userInfo)
    }

    public init(code: Int, message: String) {
        super.init(domain: FBAError.FTechDomain,
                   code: code,
                   userInfo: [NSLocalizedDescriptionKey: message])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
