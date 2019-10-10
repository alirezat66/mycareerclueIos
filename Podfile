# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'OneSignalNotificationServiceExtension' do
pod 'OneSignal', '>= 2.6.2', '< 3.0'
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for OneSignalNotificationServiceExtension

end

source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!
target 'MyCareerClue' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WeYouMaster
post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
        end
    end
end
pod 'DLRadioButton', '~> 1.4'
pod 'OneSignal', '>= 2.6.2', '< 3.0'
pod 'SVProgressHUD'
pod 'Dropper'
pod 'Alamofire', '~>4.4'
pod 'SwiftyJSON', '~> 4.0'
pod 'ReverseExtension'
pod 'DropDown', '2.3.2'
pod ‘SearchTextField’ , ’1.2.0’
pod 'XLPagerTabStrip', ‘8.0.1’
pod 'JJFloatingActionButton’, ‘0.10.0’
pod 'SwiftMessages' , ‘4.0.0’
pod 'Stripe'
pod 'MDHTMLLabel'

end

