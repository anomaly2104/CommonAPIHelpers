Pod::Spec.new do |s|
  s.name     = 'CommonAPIHelpers'
  s.version  = '0.4.1'
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

  s.platform = :ios, '5.0'
  s.header_mappings_dir = 'CommonAPIHelpers'

  s.public_header_files = ["CommonAPIHelpers/*.h"]

  s.subspec 'CAHHUD' do |ss|
    ss.dependency 'MBProgressHUD', '~> 0.9'
    ss.source_files = ['CommonAPIHelpers/CAHHUD/*.{h,m}',
                       'CommonAPIHelpers/CAHHUD.h']
    s.resources = [ 'CommonAPIHelpers/CAHHUD/*.{xcassets}']
  end

  s.subspec 'CAHMailController' do |ss|
    ss.dependency 'UIDevice-Helpers', '~> 0.0.1'
    ss.source_files = ['CommonAPIHelpers/CAHMailController/*.{h,m}',
                       'CommonAPIHelpers/CAHMailController.h',
                       'CommonAPIHelpers/CAHProductNamesFromModelVersion/*.{h,m}']
    s.resources = [ 'CommonAPIHelpers/CAHProductNamesFromModelVersion/*.{plist}']
  end

  s.subspec 'CAHGoogleAnalyticsHelper' do |ss|
    ss.dependency 'GoogleAnalytics-iOS-SDK'
    ss.source_files = ['CommonAPIHelpers/CAHGoogleAnalyticsHelper/*.{h,m}',
                       'CommonAPIHelpers/CAHGoogleAnalyticsHelper.h']
  end
end
