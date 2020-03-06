//
//  LoginModelForLine.swift
//  SSO-iOS-swift
//
//  Created by CI-Hank.Chien on 2020/2/19.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

import UIKit
import LineSDK

extension LoginResult: LoginModelSpec{
    public var userName: String {
        self.userProfile?.displayName ?? "default"
    }
    
    public var userID: String {
        self.userProfile?.userID ?? "default"
    }
    
    public var userToken: String {
        self.accessToken.value
    }
}
