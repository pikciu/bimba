platform :ios, '12.0'
use_frameworks!

inhibit_all_warnings!

workspace 'Bimba.xcworkspace'

def shared_pods 

	pod 'RxSwift'
	pod 'RxCocoa'
	pod 'RxRelay'
	pod 'RxOptional'
	pod 'RxSwiftExt'
	pod 'RxSwiftUtilities'
	pod 'RxCoreLocation'

	pod 'Swinject'
end

target 'App' do
	project 'App/App.xcodeproj'

	shared_pods

	pod 'RxCells'
	
	pod 'RealmSwift'
	pod 'RxRealm'
end

target 'Domain' do
	project 'Domain/Domain.xcodeproj'

	shared_pods
end

target 'Data' do
	project 'Data/Data.xcodeproj'

	shared_pods
	
	pod 'RealmSwift'
	pod 'RxRealm'
end


post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
		end
	end
end