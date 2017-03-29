Pod::Spec.new do |s|
  s.name    = 'Mechanica'
  s.version = '0.2.0'
  s.license = 'MIT'

  s.summary   = 'A library of Swift utils to ease your iOS/macOS/watchOS/tvOS development.'
  s.homepage  = 'https://github.com/tinrobots/Mechanica'
  s.authors   = { 'Alessandro Marzoli' => 'me@alessandromarzoli.com' }
  s.source    = { :git => 'https://github.com/tinrobots/Mechanica.git', :tag => s.version }
  
  s.ios.deployment_target     = '10.0'
  s.osx.deployment_target     = '10.12'
  s.tvos.deployment_target    = '10.0'
  s.watchos.deployment_target = '3.0'

  s.source_files = 'Sources/*.swift', 'Sources/*.{h,m}'
  
  s.tvos.exclude_files    = 'Sources/KeyboardObserver.swift'
  s.osx.exclude_files     = 'Sources/KeyboardObserver.swift'
  s.watchos.exclude_files = 'Sources/KeyboardObserver.swift', 'Sources/Storyboard.swift', 'Sources/Nib.swift'
  
end
