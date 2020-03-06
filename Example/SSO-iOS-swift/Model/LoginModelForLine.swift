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
    var userName: String {
        self.userProfile?.displayName ?? "default"
    }
    
    var userID: String {
        self.userProfile?.userID ?? "default"
    }
    
    var userToken: String {
        self.accessToken.value
    }
}
