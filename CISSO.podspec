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
  spec.version      = "0.0.1"
  spec.summary      = "A short description of CISSO."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  spec.description  = <<-DESC
                   DESC

  spec.homepage     = "https://github.com/CI-MobileTeam/SSO-iOS-Swift"
  spec.license      = { :type => "MIT", :file => "License.md" }
  spec.author             = { "Hank Chien" => "hankchien@cloud-interactive.com" }
  spec.source       = { :git => "https://github.com/CI-MobileTeam/SSO-iOS-Swift/CISSO.git", :tag => "#{spec.version}" }
  spec.swift_version = '5.0'
  spec.framework = "UIKit"
  spec.dependency 'FacebookLogin'
  spec.dependency 'GoogleSignIn', '5.0.2'
  spec.dependency 'LineSDKSwift', '5.5.1'


end
