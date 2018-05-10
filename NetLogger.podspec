#
# Be sure to run `pod lib lint NetLogger.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'NetLogger'
  s.version          = '0.1.3'
  s.summary          = 'Log and view network requests within the app itself.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
NetLogger logs the network requests made by your app. The log and details of each such request  is available to view in real time from within the app itself. The app may make network requests using any library / pod of your choice.
                       DESC

  s.homepage         = 'https://github.com/croozeus/NetLogger'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD', :file => 'LICENSE' }
  s.author           = { 'croozeus' => 'croozeus@yahoo.com' }
  s.source           = { :git => 'https://github.com/croozeus/NetLogger.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'NetLogger/Classes/**/*.{h,m}'

  s.resource_bundles = {
    'NetLogger' => ['NetLogger/Assets/*.xcassets', 'NetLogger/Classes/*.xib']
  }

  #s.public_header_files = 'Pod/Classes/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
