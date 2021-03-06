//
//  LoginModelForApple.swift
//  SSO-iOS-swift
//
//  Created by CI-Hank.Chien on 2020/2/26.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

import UIKit
import AuthenticationServices

@available(iOS 13.0, *)
extension ASAuthorizationAppleIDCredential: LoginModelSpec{
    public var userName: String {
        return self.fullName?.givenName ?? "apple give no name"
    }
    
    public var userID: String {
        return self.user
    }
    
    public var userToken: String {
        return String(data: self.identityToken ?? Data(), encoding: .utf8) ?? "apple give no token"
    }
    

}
