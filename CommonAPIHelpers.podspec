Pod::Spec.new do |s|
  s.name     = 'CommonAPIHelpers'
  s.version  = '0.2.0'
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
  s.dependency 'MBProgressHUD', '~> 0.9'
  s.dependency 'UIDevice-Helpers', '~> 0.0.1'

  s.ios.deployment_target = '7.0'
  s.header_mappings_dir = 'CommonAPIHelpers'

  s.source_files = [ 'CommonAPIHelpers/*.{h,m}', 
                     'CommonAPIHelpers/HUD/*.{h,m}',
                     'CommonAPIHelpers/MailController/*.{h,m}']
                     
  s.resources = [ 'CommonAPIHelpers/HUD/*.{xcassets}']
end
