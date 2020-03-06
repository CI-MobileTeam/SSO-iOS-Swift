//
//  LoginModel.swift
//  SSO-iOS-swift
//
//  Created by CI-Hank.Chien on 2020/2/19.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

import UIKit

public protocol LoginModelSpec {
    var userName:String{get}
    var userID:String{get}
    var userToken:String{get}
}


public struct LoginModel: LoginModelSpec {
    public let userName: String
    public let userID: String
    public let userToken: String
    
    init(userName:String, userID:String, userToken:String) {
        self.userName = userName
        self.userID = userID
        self.userToken = userToken
    }
}
