platform :ios, '13.0'
project 'SampleRxApp.xcodeproj'

target 'SampleRxApp' do
  use_frameworks!

  #3rd party
  pod 'Moya'
  pod 'Moya/RxSwift'
  pod 'Result'
  pod 'RxAppState'
  pod 'RxSwift'
  pod "RxSwiftExt"
  pod 'RxCocoa'
  pod 'RxViewModel'
  pod 'RxDataSources'
  pod 'Swinject'

  target 'SampleRxAppTests' do
    inherit! :search_paths
  end

end

# This plugin requires "gem install cocoapods-developing-folder"
plugin 'cocoapods-developing-folder'

inhibit_warnings_with_condition do |pod_name, pod_target|
  pod_target.file_accessors.first.root.to_path.start_with? pod_target.sandbox.root.to_path
end
