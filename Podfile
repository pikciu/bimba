platform :ios, '12.0'
use_frameworks!

inhibit_all_warnings!

workspace 'Bimba.xcworkspace'

def shared_pods 

	pod 'RxSwift'
	pod 'RxCocoa'
	pod 'RxRelay'
	pod 'RxOptional'
	pod 'RxSwiftExt', :git => 'https://github.com/RxSwiftCommunity/RxSwiftExt.git'
	pod 'RxSwiftUtilities', :git => 'https://github.com/RxSwiftCommunity/RxSwiftUtilities.git'
	pod 'RxCoreLocation'

	pod 'DependencyContainer'
end

def realm
	pod 'RealmSwift'
	pod 'RxRealm'
end

target 'App' do
	project 'App/App.xcodeproj'

	shared_pods

	pod 'RxCells'
	
	realm

	pod 'Firebase/Analytics'
	pod 'Firebase/Crashlytics'
end

target 'Domain' do
	project 'Domain/Domain.xcodeproj'

	shared_pods
end

target 'Data' do
	project 'Data/Data.xcodeproj'

	shared_pods
	realm
end

target 'Widget' do
	project 'App/App.xcodeproj'

	shared_pods
end

target 'Intent' do
	project 'App/App.xcodeproj'

	shared_pods
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
		end
	end
end