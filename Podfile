source 'https://github.com/CocoaPods/Specs.git'
xcodeproj 'OpenTimeSDK.xcodeproj'
platform :ios, '8.0'
use_frameworks!

target 'OpenTimeSDK' do
    
    pod 'AFNetworking', '~> 2.6.3'
    pod 'libPhoneNumber-iOS', '~> 0.8.17'
    
    # Disables bitcode after each upgrade.
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['ENABLE_BITCODE'] = 'NO'
                config.build_settings['SWIFT_VERSION'] = '3.1'
            end
        end
    end

end
