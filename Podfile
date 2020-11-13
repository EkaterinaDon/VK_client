# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'VK_client' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
pod 'Alamofire', '~> 5.2'
pod 'RealmSwift'
pod 'SwiftyJSON', '~> 4.0'
pod 'Firebase/Auth'
pod 'Firebase/Firestore'
pod 'FirebaseFirestoreSwift'
pod 'Firebase/Database'
pod 'SwiftKeychainWrapper'
  # Pods for VK_client

post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
             config.build_settings['EXCLUDED_ARCHS[sdk=iphonesimulator*]'] = 'arm64'
             config.build_settings['EXCLUDED_ARCHS[sdk=watchsimulator*]'] = 'arm64'
             config.build_settings['EXCLUDED_ARCHS[sdk=appletvsimulator*]'] = 'arm64'
    
         end
     end
 end


end
