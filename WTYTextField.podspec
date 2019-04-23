
Pod::Spec.new do |s|
    s.name             = 'WTYTextField'
    s.version          = '0.1.0'
    s.summary          = '自定义TextField.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    TODO: 适合用户名、密码的TextField.
    DESC
    
    s.homepage         = 'https://github.com/LTY2009/WTYTextField'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'litengyue' => 'litengyue117@163.com' }
    s.source           = { :git => 'https://github.com/LTY2009/WTYTextField.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
    
    s.ios.deployment_target = '8.0'
    s.swift_version = '5.0'
    
    s.source_files = 'WTYTextField/Classes/**/*.swift'
    
    s.resource_bundles = {
        'WTYTextField' => ['WTYTextField/Assets/*.png']
    }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
end
