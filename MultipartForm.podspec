Pod::Spec.new do |s|
  s.name             = 'MultipartForm'
  s.version          = '0.1.0'
  s.summary          = 'The missing multipart form support for URLSession.'

  s.homepage         = 'https://github.com/davbeck/MultipartForm'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'davbeck' => 'code@davidbeck.co' }
  s.source           = { :git => 'https://github.com/davbeck/MultipartForm.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/davbeck'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target  = '10.10'

  s.swift_version = '5.1'
  s.source_files = 'Sources/MultipartForm/*.swift'
  
  s.test_spec 'MultipartFormTests' do |test_spec|
    test_spec.source_files = 'Tests/MultipartFormTests/*'
  end  
end
