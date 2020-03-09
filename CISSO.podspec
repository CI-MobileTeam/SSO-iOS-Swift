#
#  Be sure to run `pod spec lint CISSO.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  spec.name         = "CISSO"
  spec.version      = "1.0.0"
  spec.summary      = "just for third party login"
  spec.description  = "just for third party login first test"

  spec.homepage     = "https://github.com/CI-MobileTeam/SSO-iOS-Swift"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Hank Chien" => "hankchien@cloud-interactive.com" }
  spec.platform     = :ios, "10.0"
  spec.source       = { :git => "https://github.com/CI-MobileTeam/SSO-iOS-Swift.git", :tag => spec.version }
  spec.swift_version = '5.0'
  spec.source_files = "CISSO/**/*.swift"
  spec.frameworks = "UIKit"
  spec.dependency 'FacebookLogin'
  spec.dependency 'GoogleSignIn', '5.0.2'
  spec.dependency 'LineSDKSwift', '5.5.1'
  spec.dependency 'FacebookSDK/CoreKit'
  spec.dependency 'FBSDKShareKit'
  spec.static_framework = true
  spec.requires_arc = true

end
