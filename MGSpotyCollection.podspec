Pod::Spec.new do |s|

  s.name         = 'MGSpotyCollection'
  s.version      = '0.1.0'
  s.summary      = 'Beautiful ViewController with a CollectionView and amazing effects.'

  s.description  = <<-DESC
                   Beautiful ViewController with a CollectionView and amazing effects.

                   Base on MGSpotyViewController

                   DESC

  s.homepage     = 'https://github.com/yourtion/MGSpotyCollection'

  s.license      = 'MIT'
  s.author       = { 'Yourtion' => 'yourtion@gmail.com' }
  s.platform     = :ios
  s.source       = { :git => 'https://github.com/yourtion/MGSpotyCollection.git', :tag => s.version }
  s.source_files = 'MGSpotyCollection/*.{h,m}', 'MGSpotyCollection/ImageEffects/*.{h,m}'
  s.frameworks   = 'Foundation', 'UIKit'
  s.requires_arc = true

end
