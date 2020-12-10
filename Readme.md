## CISSO
這是一個整合簡化第三方登入的套件,目前支援facebook,google,line,apple sign in等登入方式

## First step
如需要使用某第三方登入,請先至該服務之官網申請相關註冊並拿到所需資料 ex:facebookAppID,googleAppID. 

## Second step
podfile增加 CISSO

```
target 'YOURPROJECT' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for YOURPROJECT
    pod 'CISSO'
end

```

## Third step
在info.plist增加您申請的服務相對應的url scheme設定以及LSApplicationQueriesSchemes

```
<key>CFBundleURLTypes</key>
<array>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLName</key>
		<string>GoogleSignIn</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>com.googleusercontent.apps.YOUR_APP_REGIST_CODE</string>
		</array>
	</dict>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLName</key>
		<string>LineLogin</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>line3rdp.YOUR_APP_REGIST_BUNDLE_ID</string>
		</array>
	</dict>
	<dict>
		<key>CFBundleTypeRole</key>
		<string>Editor</string>
		<key>CFBundleURLName</key>
		<string>Facebook</string>
		<key>CFBundleURLSchemes</key>
		<array>
			<string>FROM_FB_REGIST</string>
		</array>
	</dict>
</array>

```
```
<key>LSApplicationQueriesSchemes</key>
	<array>
		<string>lineauth2</string>
		<string>line</string>
		<string>fbapi</string>
		<string>fbapi20130214</string>
		<string>fbapi20130410</string>
		<string>fbapi20130702</string>
		<string>fbapi20131010</string>
		<string>fbapi20131219</string>
		<string>fbapi20140410</string>
		<string>fbapi20140116</string>
		<string>fbapi20150313</string>
		<string>fbapi20150629</string>
		<string>fbapi20160328</string>
		<string>fbauth</string>
		<string>fbauth2</string>
		<string>fbshareextension</string>
	</array>

```

## Fourth step
在AppDelegate導入CISSO,並在lauch func中實作您所需的dataSource,如不需要使用的第三方服務可以不實作,並且呼叫config讓manager幫您完成相關設定

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    SSOManager.shared().facebookDataSource(dataSource: self)
    //SSOManager.shared().lineDataSource(dataSource: self)
    SSOManager.shared().setConfig(application: application, launchOptions: launchOptions, dataSource: self)
        
        
    return true
}

```

```swift
extension AppDelegate: FacebookDataSource{
    var facebookAppID: String {
        return "YOUR_FACEBOOK_APPID"
    }
    
    var facebookDisplayName: String {
        return "YOUR_FACEBOOK_DISPLAYNAME"
    }
}

```

## Fiveth Step
在Appdelegate中的openurl handle各平台轉跳邏輯

```swift
func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {


    
    return SSOManager.shared().handleOpenUrl(app: app, url: url, options: options)


}

```

## Sixth Step
在您想要執行登入動作時呼叫func並且選擇好登入type, handle result即可完成登入動作

```swift
SSOManager.shared().loginWithThirdParty(type: .FACEBOOKLOGIN, presentVC: self) { (result) in
    switch result{
    case .success(let model):
        print(model)          
    case .cancelled:
        return
    case .failure(let error):
        print(error.localizedDescription)
    }
}

```

## License

MacDown is released under the terms of MIT License. For more details take a look at the [License](https://github.com/CI-MobileTeam/SSO-iOS-Swift/License.md).

