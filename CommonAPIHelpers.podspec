Pod::Spec.new do |s|
  s.name     = 'CommonAPIHelpers'
  s.version  = '0.4.4'
  s.summary  = 'Library containing Helpers for some common APIs for ios'
  s.homepage = 'https://github.com/uditiiita/CommonAPIHelpers'
  s.author   = 'Udit Agarwal'
  s.license  = 'MIT'
  s.source   = {
    :git => 'git@github.com:uditiiita/CommonAPIHelpers.git',
    :tag => s.version, 
    :submodules => true
  }
  s.requires_arc = true

  s.dependency 'TDTChocolate/FoundationAdditions'  

  s.platform = :ios, '6.0'

  s.public_header_files = ["CommonAPIHelpers/*.h"]
  s.source_files = ["CommonAPIHelpers/CommonAPIHelpers.h"]

  s.subspec 'CAHHUD' do |ss|
    ss.dependency 'MBProgressHUD', '~> 0.9'
    ss.source_files = ['CommonAPIHelpers/CAHHUD/*.{h,m}']
    ss.resources = [ 'CommonAPIHelpers/CAHHUD/*.{xcassets}']
  end

  s.subspec 'CAHMailController' do |ss|
    ss.dependency 'UIDevice-Helpers', '~> 0.0.1'
    ss.source_files = ['CommonAPIHelpers/CAHMailController/*.{h,m}',
                       'CommonAPIHelpers/CAHProductNamesFromModelVersion/*.{h,m}']
    ss.resources = [ 'CommonAPIHelpers/CAHProductNamesFromModelVersion/*.{plist}']
  end

  s.subspec 'CAHGoogleAnalyticsHelper' do |ss|
    ss.dependency 'GoogleAnalytics-iOS-SDK'
    ss.source_files = ['CommonAPIHelpers/CAHGoogleAnalyticsHelper/*.{h,m}']
  end
end
