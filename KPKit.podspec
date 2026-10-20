Pod::Spec.new do |s|
  s.name             = "KPKit"
  s.version          = "2.0.0"
  s.summary          = "Library of utility methods bringing handy functions from openFrameworks and Processing to Cocoa."
  s.homepage         = "https://github.com/kitschpatrol/KPKit"
  s.license          = 'MIT'
  s.author           = { "kitschpatrol" => "eric@ericmika.com" }
  s.social_media_url = 'https://twitter.com/kitschpatrol'
  s.platform     = :ios, '12.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes'
	s.source       = { :git => "https://github.com/kitschpatrol/KPKit.git", :tag => s.version.to_s }
end
