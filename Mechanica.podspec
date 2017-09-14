Pod::Spec.new do |s|
  s.name    = 'Mechanica'
  s.version = '1.0.0'
  s.license = 'MIT'
  s.documentation_url = 'http://www.tinrobots.org/Mechanica'  
  s.summary   = 'A library of Swift utils to ease your iOS/macOS/watchOS/tvOS development.'
  s.homepage  = 'https://github.com/tinrobots/Mechanica'
  s.authors   = { 'Alessandro Marzoli' => 'me@alessandromarzoli.com' }
  s.source    = { :git => 'https://github.com/tinrobots/Mechanica.git', :tag => s.version }
  s.requires_arc = true
  
  s.ios.deployment_target     = '10.0'
  s.osx.deployment_target     = '10.12'
  s.tvos.deployment_target    = '10.0'
  s.watchos.deployment_target = '3.0'

  s.source_files =  'Sources/*.swift', 
                    'Sources/*.{h,m}',
                    'Sources/Color/*.swift',
                    'Sources/CoreData/*.swift',
                    'Sources/CoreData/NSManagedObject/*.swift',
                    'Sources/CoreData/NSManagedObjectContext/*.swift',
                    'Sources/Dictionary/*.swift',
                    'Sources/Integer/*.swift',
                    'Sources/Interface Builder/*.swift',
                    'Sources/NSAttributedString/*.swift',
                    'Sources/NSObject/*.swift',      
                    'Sources/Protocols/*.swift',
                    'Sources/String/*.swift',
                    'Sources/UIKit/*.swift'
  
  s.osx.exclude_files = 'Sources/UIKit/*.swift'
  
  s.watchos.exclude_files = 'Sources/Interface Builder/Storyboard.swift', 
                            'Sources/Interface Builder/Nib.swift',
                            'Sources/UIKit/UIButton+Utils.swift', 
                            'Sources/UIKit/UICollectionView+Reusable.swift',
                            'Sources/UIKit/UITableView+Reusable.swift'
end
