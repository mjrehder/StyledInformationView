Pod::Spec.new do |s|
  s.name             = 'StyledInformationView'
  s.version          = '1.0'
  s.license          = 'MIT'
  s.summary          = 'StyledInformationView is a UIView for displaying a header, a menu and a detailed description.'
  s.homepage         = 'https://github.com/mjrehder/StyledInformationView.git'
  s.authors          = { 'Martin Jacob Rehder' => 'gitrepocon01@rehsco.com' }
  s.source           = { :git => 'https://github.com/mjrehder/StyledInformationView.git', :tag => s.version }
  s.ios.deployment_target = '9.0'

  s.dependency 'MJRFlexStyleComponents'
  s.dependency 'StyledOverlay'
  
  s.framework    = 'UIKit'
  s.source_files = 'StyledInformationView/*.swift'
  s.requires_arc = true
end
