//
//  LoginModel.swift
//  SSO-iOS-swift
//
//  Created by CI-Hank.Chien on 2020/2/19.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

import UIKit

protocol LoginModelSpec {
    var userName:String{get}
    var userID:String{get}
    var userToken:String{get}
}


struct LoginModel: LoginModelSpec {
    let userName: String
    let userID: String
    let userToken: String
    
    init(userName:String, userID:String, userToken:String) {
        self.userName = userName
        self.userID = userID
        self.userToken = userToken
    }
}
