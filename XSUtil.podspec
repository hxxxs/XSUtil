
Pod::Spec.new do |s|
  s.name             = 'XSUtil'
  s.version          = '2.0.0'
  s.summary          = '公用类抽取'

  s.homepage         = 'https://github.com/hxxxs'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Cedar' => 'lychae@foxmail.com' }
  s.source           = { :git => 'https://github.com/hxxxs/XSUtil.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'

  s.source_files = 'XSUtil/Classes/**/*'
  
  s.resource_bundles = {
    'XSUtil' => ['XSUtil/Assets/*.png']
  }

  s.dependency 'XSExtension'
  s.dependency 'SnapKit'
  s.swift_version = '5.0'

end
