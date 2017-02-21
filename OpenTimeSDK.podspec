#
# Be sure to run `pod lib lint OpenTimeSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OpenTimeSDK'
  s.version          = '0.1.0'
  s.summary          = 'The iOS SDK for OpenTime®'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
The iOS SDK for the OpenTime® enterprise software application makes it easy for iOS developers
trying to integration with the OpenTime REST API simple and fast.
See also https://webservice.opentime.us/docs/
                       DESC

  s.homepage         = 'https://github.com/OpenTimeApp/OpenTimeIOSSDK'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'woodcockjosh' => 'josh.woodcock@opentimeapp.com' }
  s.source           = { :git => 'https://github.com/OpenTimeApp/OpenTimeIOSSDK.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/OpenTimeApp'

  s.ios.deployment_target = '9.0'

  s.source_files = 'OpenTimeSDK/Classes/**/*'
  s.dependency 'AFNetworking', '~> 2.6.3'
  s.dependency 'libPhoneNumber-iOS', '~> 0.8.17'
  s.dependency 'SCrypto'
end
