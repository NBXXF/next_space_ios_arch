#
# Be sure to run `pod lib lint next_space_ios_arch.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'next_space_ios_arch'
  s.version          = '0.1.1'
  s.summary          = 'A short description of next_space_ios_arch.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://codeup.aliyun.com/62ab111798b10058fdb78c54/byte_flow/next_space_ios_arch.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'xxf' => 'xuanyouwu@163.com' }
  s.source           = { :git => 'https://codeup.aliyun.com/62ab111798b10058fdb78c54/byte_flow/next_space_ios_arch.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '10.0'

  s.source_files = 'next_space_ios_arch/Classes/**/*'
  s.prefix_header_file = false
  s.prefix_header_file = 'XXFPrefixHeader.pch'


 s.public_header_files = 'Pod/Classes/**/*'
 s.dependency 'JLRoutes'
 s.dependency 'ReactiveObjC', '~> 3.1.1'
 s.dependency 'Masonry'
 s.dependency 'AFNetworking'
 s.dependency 'MMKV'
 s.dependency 'YYModel'
 s.dependency 'YYCache'
 s.dependency 'pop'
 s.dependency "KVOMutableArray/ReactiveCocoaSupport" #可监听的数组
 s.dependency 'Tiercel' #下载框架
end
