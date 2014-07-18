#
# Be sure to run `pod lib lint MightyIO-iOS-Pod.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# Any lines starting with a # are optional, but encouraged
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "MightyIO-iOS-Pod"
  s.version          = "0.1.4"
  s.summary          = "The MightyIO SDK, by SuperMighty"
  s.homepage         = "https://github.com/TheSuperMighty/MightyIO-iOS-Pod"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Gavin Potts" => "gavin@supermighty.com" }
  s.source           = { :git => "https://github.com/TheSuperMighty/MightyIO-iOS-Pod.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/thesupermighty'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.preserve_paths = 'Pod/Classes/MightyIO.framework',
  s.public_header_files = 'Pod/Classes/MightyIO.framework/**/*.h'
  s.vendored_frameworks = 'Pod/Classes/MightyIO.framework'
  s.frameworks = 'UIKit', 'MapKit','Social', 'StoreKit'
  s.dependency 'Parse-iOS-SDK', '~> 1.2'
end
