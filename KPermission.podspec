Pod::Spec.new do |s|

s.name         = "KPermission"
s.version      = "1.0.3"
s.summary      = "Easy request permissions on iOS"
s.description  = <<-DESC
Easy request permissions on iOS
DESC
s.homepage     = "https://github.com/KenanAtmaca/KPermission"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author             = { "KenanAtmaca" => "mail.kenanatmaca@gmail.com" }
s.social_media_url   = "https://twitter.com/uikenan"

s.platform     = :ios, "11.0"
s.requires_arc = true
s.ios.deployment_target = "11.0"

s.source       = { :git => "https://github.com/KenanAtmaca/KPermission", :tag => "#{s.version}" }
s.source_files  = "KPermission", "KPermission/**/*.{h,m,swift}"
s.resources = "KPermission/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
s.swift_version = '4.2'
s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.2'}
end
