platform :ios, '12.0'

project 'TestApp.xcodeproj'

plugin 'cocoapods-art', sources: %w[
  bbartifacts3
  bbartifacts-retail3
]

install! 'cocoapods', 
  deterministic_uuids: false, 
  disable_input_output_paths: true,
  share_schemes_for_development_pods: true

source 'https://cdn.cocoapods.org/'

use_frameworks!
inhibit_all_warnings!

$resolverVersion = '1.2.1'
$backbaseVersion = '~> 8.0'
$designSystemVersion = '~> 1.5'

abstract_target 'Common' do
  # Common journey dependencies
  pod 'Backbase', $backbaseVersion
  pod 'SwiftLint'
  pod 'Resolver', $resolverVersion
  pod 'RetailDesign', '~> 1.0'
  pod 'RetailJourneyCommon', '~> 1.0'

  target 'TestApp' do
    pod 'BackbaseRemoteConfig'
  end

  target 'WhatsNewJourney' do
    pod 'RxDataSources',        '~> 4.0'
    pod 'RxAnimated',           '~> 0.7'
    pod 'BackbaseDesignSystem', $designSystemVersion
  end

end

abstract_target 'Tests' do
  pod 'RxTest', '~> 5'
  pod 'RxBlocking', '~> 5'
  pod 'Backbase', $backbaseVersion
  pod 'Resolver', $resolverVersion
  pod 'RxNimble', '~> 5.0'
  pod 'RxNimble/RxTest', '~> 5.0'
  pod 'Quick', '~> 3.0'

  target 'WhatsNewJourneyUnitTests'
  target 'WhatsNewJourneySnapshotTests' do
    pod 'SnapshotTesting', '~> 1.8'
  end
  
end


post_install do |installer_representation|
  installer_representation.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['CLANG_ENABLE_CODE_COVERAGE'] = 'NO'
      config.build_settings['ENABLE_BITCODE'] = 'YES'
      config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ''
      config.build_settings['CODE_SIGNING_REQUIRED'] = 'NO'
      config.build_settings['CODE_SIGNING_ALLOWED'] = 'NO'

      cflags = config.build_settings['OTHER_CFLAGS'] || ['$(inherited)']
      if config.name == 'Release'
        cflags << '-fembed-bitcode'
        config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
      else
        cflags << '-fembed-bitcode-marker'
        config.build_settings['BITCODE_GENERATION_MODE'] = 'marker'
      end

      config.build_settings['OTHER_CFLAGS'] = cflags
    end
  end
end
