Pod::Spec.new do |s|
  s.name         = "KPUtilities"
  s.platform     = :ios
  s.version      = "1.0.1"
  s.summary      = "An obligatory bundle of utility methods centered around bringing some of the handy shortcuts from the openFrameworks and Processing projects to Cocoa."
  s.homepage     = "https://github.com/kitschpatrol/KPUtilities"
  s.license      = "MIT"
  s.authors      = { "Eric Mika" => "ermika@gmail.com" }
  s.source       = { :git => "https://github.com/kitschpatrol/KPUtilities", :tag => '1.0.1' }
  s.framework    = 'UIKit'
  s.source_files = '*.{h,m}'
  s.requires_arc = true
end
