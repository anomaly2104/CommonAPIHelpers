Pod::Spec.new do |s|
  s.name     = 'CommonAPIHelpers'
  s.version  = '1.0.0'
  s.summary  = 'Library containing Helpers for some common APIs for ios'
  s.homepage = 'https://github.com/uditiiita/CommonAPIHelpers'
  s.author   = 'Talk.to'
  s.license  = 'BSD'
  s.source   = {
    :git => 'git@github.com:uditiiita/CommonAPIHelpers.git',
    :tag => "#{s.version}"
  }
  s.requires_arc = true

  s.dependency 'TDTChocolate/FoundationAdditions'
  s.dependency 'GoogleAnalytics-iOS-SDK'

  s.ios.deployment_target = '7.0'
  s.header_mappings_dir = 'CommonAPIHelpers'

  s.source_files = [ 'CommonAPIHelpers/*.{h,m}']
  s.public_header_files = 'NSData+CommonAPIHelpers/*.h'
end
