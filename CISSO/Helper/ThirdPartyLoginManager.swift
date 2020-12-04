//
//  LoginManager.swift
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
import AuthenticationServices


//Open file
public protocol SSODataSource {
    func lineDataSource(dataSource: LineDataSource)
    func facebookDataSource(dataSource: FacebookDataSource)
    func googleDataSource(dataSource: GoogleDataSource)
}

public protocol SSOAction{
    
    func setConfig(application:UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?, dataSource:ThirdPartyLoginManagerDataSource) -> ()
    
    func handleOpenUrl(app:UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool

    func loginWithThirdParty(type:LoginType, presentVC:UIViewController, completion:@escaping (Result<LoginModelSpec, Error>) -> Void)

}

public class SSOManager {
    public class func shared() -> SSODataSource & SSOAction {
        return ThirdPartyLoginManager.share
    }
}




public enum LoginType {
    case APPLELOGIN
    case FACEBOOKLOGIN
    case GOOGLELOGIN
    case LINELOGIN
}

public enum Result<LoginModelSpec, Error> {
    case success(model:LoginModelSpec)
    case cancelled
    case failure(error:Error)
}

public protocol ThirdPartyLoginManagerDataSource:NSObject {

}

public protocol FacebookDataSource: ThirdPartyLoginManagerDataSource {
    var facebookAppID:String{get}
    var facebookDisplayName:String{get}
}

public protocol LineDataSource: ThirdPartyLoginManagerDataSource {
    var lineChannel:String{get}
}

public protocol GoogleDataSource: ThirdPartyLoginManagerDataSource {
    var googleAppID:String{get}
}


//private
typealias LoginCompletion = (Result<LoginModelSpec, Error>) -> Void

class ThirdPartyLoginManager: NSObject, SSODataSource, SSOAction{
    func facebookDataSource(dataSource: FacebookDataSource) {
        self.facebookDataSource = dataSource
    }
    
    func googleDataSource(dataSource: GoogleDataSource) {
        self.googleDataSource = dataSource
    }
    
    func lineDataSource(dataSource: LineDataSource) {
        self.lineDataSource = dataSource
    }
    
    public static let share: SSODataSource & SSOAction = ThirdPartyLoginManager()
    weak var lineDataSource:LineDataSource?
    weak var facebookDataSource:FacebookDataSource?
    weak var googleDataSource:GoogleDataSource?
    //private property
    private var loginCallBack: LoginCompletion?
    private lazy var delegateVC: DelegateViewController = {
        let vc = DelegateViewController()
        vc.delegate = self
        return vc
    }()
    
    public func setConfig(application:UIApplication, launchOptions: [UIApplication.LaunchOptionsKey: Any]?, dataSource:ThirdPartyLoginManagerDataSource) -> () {
        
        if let dataSource = lineDataSource {
            if dataSource.lineChannel.count == 0 {
                fatalError("must confirm ThirdPartyLoginManagerDataSource to set lineChannel")
            }else{
                LoginManager.shared.setup(channelID:dataSource.lineChannel, universalLinkURL: Optional(nil))
            }
        }
        
        if let dataSource = googleDataSource {
            if dataSource.googleAppID.count == 0 {
                fatalError("must confirm ThirdPartyLoginManagerDataSource to set googleAppID")
            }else{
                GIDSignIn.sharedInstance()?.clientID = dataSource.googleAppID
                GIDSignIn.sharedInstance()?.delegate = self.delegateVC
            }
        }
        
        if let dataSource = facebookDataSource {
            if dataSource.facebookAppID.count == 0 {
                fatalError("must confirm ThirdPartyLoginManagerDataSource to set facebookAppID")
            }else if dataSource.facebookDisplayName.count == 0 {
                fatalError("must confirm ThirdPartyLoginManagerDataSource to set facebookDisplayName")
            }else{
                Settings.appID = dataSource.facebookAppID
                Settings.displayName = dataSource.facebookDisplayName
                ApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
            }
        }
    }
    
    public func handleOpenUrl(app:UIApplication, url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        print(url.description)
        if ApplicationDelegate.shared.application(app, open: url, options: options){
            return true
        }

        if LoginManager.shared.application(app, open: url){
            return true
        }
        
        return false
    }
    
    public func loginWithThirdParty(type:LoginType, presentVC:UIViewController, completion:@escaping (Result<LoginModelSpec, Error>) -> Void){
        self.loginCallBack = completion
        switch type {
        case .APPLELOGIN:
            self.loginWithApple()
            break
        case .FACEBOOKLOGIN:
            self.loginWithFB(presentVC: presentVC)
            break
        case .GOOGLELOGIN:
            self.loginWithGoogle(presentVC: presentVC)
            break
        case .LINELOGIN:
            self.loginWithLine(presentVC: presentVC)
            break
        }
    }
    
    private func loginWithGoogle(presentVC:UIViewController) -> () {
        GIDSignIn.sharedInstance()?.presentingViewController = presentVC
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    private func loginWithLine(presentVC:UIViewController) -> () {
        LoginManager.shared.login(permissions: [.profile,.friends,.groups]/*, in: presentVC, options:.botPromptNormal*/) {(result) in
            switch result{
            case .success(let loginResult):
                if let callback = self.loginCallBack {
                    callback(.success(model: loginResult))
                }
                break
            case .failure(let error):
                switch error {
                case .authorizeFailed(reason: .userCancelled):
                    if let callback = self.loginCallBack {
                        callback(.cancelled)
                    }
                    break
                default:
                    if let callback = self.loginCallBack {
                        callback(.failure(error: error))
                    }
                }
            }
        }
    }
    
    private func loginWithFB(presentVC:UIViewController) -> () {
        let loginManager = LoginManager()
        loginManager.logIn(permissions: [.publicProfile], viewController: presentVC) { (Result) in
            switch Result{
            case .success( _, _, let AccessToken):
                Profile.loadCurrentProfile { (profile, error) in
                    if let file = profile {
                        let model = LoginModel(userName: file.name ?? "no name", userID: AccessToken.userID, userToken:AccessToken.tokenString)
                        if let callback = self.loginCallBack {
                            callback(.success(model: model))
                        }
                    }
                }
                break
            case .failed(let error):
                if let callback = self.loginCallBack {
                    callback(.failure(error: error))
                }
                break
            case .cancelled:
                if let callback = self.loginCallBack {
                    callback(.cancelled)
                }
                break
            }
        }
    }
    
    @objc func loginWithApple() {
        if #available(iOS 13.0, *) {
            let appleIDProvider = ASAuthorizationAppleIDProvider()
            let request = appleIDProvider.createRequest()
            request.requestedScopes = [.fullName, .email]
            let authorizationController = ASAuthorizationController(authorizationRequests: [request])
            authorizationController.delegate = self
            authorizationController.performRequests()
        } else {
            // callback on earlier versions
            let error = NSError(domain: "only support after iOS 13", code: 5000, userInfo: Optional(nil))
            if let callback = loginCallBack {
                callback(.failure(error: error))
            }
        }
    }
    
}

extension ThirdPartyLoginManager: DelegateViewControllerCallBack{
    
    func loginSuccessCallBack(success: Bool, model: LoginModelSpec, error: Error?) {
        if let callback = self.loginCallBack {
            callback(.success(model: model))
        }
    }
    
    func loginCancel() {
        if let callback = self.loginCallBack {
            callback(.cancelled)
        }
    }
    
    func loginFailCallBack(error: Error) {
        if let callback = self.loginCallBack {
            callback(.failure(error: error))
        }
    }
}

extension ThirdPartyLoginManager: ASAuthorizationControllerDelegate{
    @available(iOS 13.0, *)
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        if let callback = self.loginCallBack {
            callback(.failure(error: error))
        }
    }
    
    @available(iOS 13.0, *)
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        guard let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential else {return}
        if let callback = self.loginCallBack {
            callback(.success(model: appleIDCredential))
        }
    }
}
