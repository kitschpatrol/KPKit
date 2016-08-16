Pod::Spec.new do |s|
  s.name             = "KPKit"
  s.version          = "1.0.6"
  s.summary          = "An bundle of utility methods centered around bringing some of the handy shortcuts from the openFrameworks and Processing projects to Cocoa."
  s.homepage         = "https://github.com/kitschpatrol/KPKit"
  s.license          = 'MIT'
  s.author           = { "kitschpatrol" => "eric@ericmika.com" }
  s.social_media_url = 'https://twitter.com/kitschpatrol'
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'Pod/Classes'
	s.source       = { :git => "https://github.com/kitschpatrol/KPKit.git", :tag => s.version.to_s }
end
