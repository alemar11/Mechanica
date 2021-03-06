Pod::Spec.new do |s|
  s.name              = 'Mechanica'
  s.version           = '3.1.0'
  s.license           = 'MIT'
  s.documentation_url = 'http://www.alessandromarzoli.com/Mechanica'  
  s.summary           = 'A library of Swift utils to ease your iOS/macOS/watchOS/tvOS development.'
  s.homepage          = 'https://github.com/alemar11/Mechanica'
  s.authors           = { 'Alessandro Marzoli' => 'me@alessandromarzoli.com' }
  s.source            = { :git => 'https://github.com/alemar11/Mechanica.git', :tag => s.version }
  s.requires_arc      = true
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0'}
  
  s.swift_version = "5.0"
  s.ios.deployment_target     = '12.0'
  s.osx.deployment_target     = '10.14'
  s.tvos.deployment_target    = '12.0'
  s.watchos.deployment_target = '5.0'

  s.source_files =  'Sources/*.swift', 
                    'Support/*.{h,m}',
                    'Sources/AppKit/*.swift',
                    'Sources/CoreGraphics/*.swift',
                    'Sources/Foundation/*.swift',
                    'Sources/Shared/*.swift',
                    'Sources/StandardLibrary/*.swift',
                    'Sources/UIKit/*.swift'
  
  s.ios.exclude_files = 'Sources/AppKit/*.swift'

  s.tvos.exclude_files = 'Sources/AppKit/*.swift'

  s.watchos.exclude_files = 'Sources/AppKit/*.swift'

  s.osx.exclude_files = 'Sources/UIKit/*.swift'
  
end
