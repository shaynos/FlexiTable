Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "FlexiTable"
s.summary = "FlexiTable."
s.requires_arc = true
s.description = "FlexiTable provides a simple way to display multiple sets of information in a single UITableview."
s.version = "0.2.0"

s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Shayne Brady" => "hello@shaynebrady.com" }
s.homepage = "https://github.com/shaynos/FlexiTable"
s.source = { :git => "https://github.com/shaynos/FlexiTable.git",
:tag => "#{s.version}" }
s.source_files = "FlexiTable/**/*.{swift}"
s.resources = 'FlexiTable/Assets/*.png'
s.swift_version = "4.2"

end
