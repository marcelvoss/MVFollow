Pod::Spec.new do |s|
  s.name         = "MVFollow"
  s.version      = "0.3.0"
  s.summary      = "MVFollow is a simple drop-in solution that allows you to follow people on Twitter natively."
  s.homepage     = "https://github.com/marcelvoss/MVFollow"
  s.license      = {
    :type => 'MIT',
    :file => 'LICENSE.md'
  }
  s.author             = {
    "Marcel Voss" => "me@marcelvoss.com"
  }
  s.platform     = :ios, '8.0'
  s.source       = {
    :git => "https://github.com/marcelvoss/MVFollow.git",
    :tag => "0.3.0"
  }
  s.source_files  = 'MVFollow/*.{swift}'
  s.frameworks = 'Social', 'Accounts'
  s.requires_arc = true
end
