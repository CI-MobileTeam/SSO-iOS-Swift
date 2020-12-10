//
//  ViewController.swift
//  SSO-iOS-swift
//
//  Created by CI-Hank.Chien on 2020/2/19.
//  Copyright © 2020 CI-Hank.Chien. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func loginWithFb(_ sender: Any) {
        ThirdPartyLoginManager.share.loginWithThirdParty(type: .GOOGLELOGIN, presentVC: self) { (result) in
            switch result{
            case .success(let model):
                print(model.userName)
                break
            case .cancelled:
                break
            case .failure(let error):
                print(error.localizedDescription)
                break
            }
        }
    }
    @IBAction func check(_ sender: Any) {
        ThirdPartyLoginManager.share.checkAuthen { (result) in
            ThirdPartyLoginManager.share.checkAuthen { (result) in
                print("authenResult=\(result)")
            }
        }
    }
    @IBAction func logout(_ sender: Any) {
        ThirdPartyLoginManager.share.logout {
            print("logout")
        }
    }
    
    
}

