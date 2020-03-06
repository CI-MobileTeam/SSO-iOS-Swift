//
//  DelegateViewController.swift
//  SSO-iOS-swift
//
//  Created by CI-Hank.Chien on 2020/2/19.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

import UIKit
import LineSDK
import GoogleSignIn
import FacebookLogin
import FacebookCore

protocol DelegateViewControllerCallBack: AnyObject {
    func loginSuccessCallBack(success:Bool, model:LoginModelSpec, error:Error?) -> ()
    func loginFailCallBack(error:Error) -> ()
}

class DelegateViewController: UIViewController{
    weak var delegate: DelegateViewControllerCallBack?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}

extension DelegateViewController: GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            self.delegate?.loginSuccessCallBack(success: true, model: LoginModel(userName: user.profile.name, userID: user.userID, userToken: user.authentication.accessToken), error: Optional(nil))
        }else{
            self.delegate?.loginFailCallBack(error: error)
        }
    }
}

