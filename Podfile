platform :ios, '13.0'
inhibit_all_warnings!
source 'https://github.com/CocoaPods/Specs.git'

target 'Sample' do
  use_frameworks!
end

target 'Interface' do
  use_frameworks!
  pod 'SnapKit', '5.0.1'
end

target 'Sound' do
  use_frameworks!
  pod 'TPCircularBuffer', '1.6.1'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
end
