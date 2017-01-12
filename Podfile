# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'MessagesExtension' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'RxCocoa'
  pod 'RxDataSources', '1.0.0-beta.2'
  pod 'NSObject+Rx', git: "https://github.com/RxSwiftCommunity/NSObject-Rx.git", branch: "master"
  pod 'RxSwift', '3.0.0-beta.1'
  pod 'Realm'
  pod 'RealmSwift', "~> 1.1"
  pod "RxRealm", '~> 0.2'
end

target 'Poll' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end
