#
# Be sure to run `pod lib lint NAME.podspec' to ensure this is a
# valid spec and remove all comments before submitting the spec.
#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = "EYToolkit"
  s.version          = "1.0.0"
  s.summary          = "A tool kit of iOS development"
  s.homepage         = "https://github.com/yang6512/EYToolkit"
  s.license          = 'MIT'
  s.author           = { "Edward Yang" => "edward.yangyk@gmail.com" }
  s.source           = { :git => "https://github.com/yang6512/EYToolkit.git", :tag => s.version.to_s }

  s.platform     = :ios, '5.0'
  s.ios.deployment_target = '5.0'
  s.requires_arc = true

  s.source_files = 'EYToolkit/EYToolkit/**/*.{h,m}'
  s.ios.exclude_files = 'EYToolkit/EYToolkit/*.pch'
  # s.public_header_files = 'Classes/**/*.h'
  s.frameworks = 'CoreGraphics'
end
