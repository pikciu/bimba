platform :ios, '12.0'
use_frameworks!

inhibit_all_warnings!

workspace 'Bimba.xcworkspace'

def shared_pods 

	pod 'RxSwift'
	pod 'RxRelay'
	pod 'RxOptional'
	pod 'RxSwiftExt'
	pod 'Swinject'
end

target 'App' do
	project 'App/App.xcodeproj'

	shared_pods

	pod 'RxCocoa'
	pod 'RxCells'
end

target 'Domain' do
	project 'Domain/Domain.xcodeproj'

	shared_pods
end

target 'Data' do
	project 'Data/Data.xcodeproj'

	shared_pods
end
