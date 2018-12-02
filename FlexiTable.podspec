Pod::Spec.new do |s|

# 1
s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "FlexiTable"
s.summary = "FlexiTable."
s.requires_arc = true

# 2
s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Shayne Brady" => "hello@shaynebrady.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/shaynos/FlexiTable"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/shaynos/FlexiTable.git",
:tag => "#{s.version}" }

# 8
s.source_files = "FlexiTable/**/*.{swift}"

# 9
s.resources = "FlexiTable/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

# 10
s.swift_version = "4.2"

end
