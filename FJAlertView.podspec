Pod::Spec.new do |s|
  s.name             = 'FJAlertControlelr'
  s.version          = '0.1.0'
  s.summary          = 'a custom AlertView like UIAlertViewController'
  s.homepage         = 'https://github.com/fengarenas/FJAlertView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'fengj' => '337109612@qq.com' }
  s.source           = { :git => 'https://github.com/fengarenas/FJAlertView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'FJAlertView/Classes/**/*'
  s.dependency 'Masonry', '~> 1.1.0'
  s.requires_arc = true
end
