#
# Be sure to run `pod lib lint AudioTabBarController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AudioTabBarController'
  s.version          = '0.1.1'
  s.summary          = 'AudioTabBarController is a custom tab bar controller to mimick playback view like on apple music or spotify.'
  s.description      = <<-DESC
                       AudioTabBarController will show playback audio on the bottom tab bar, and can be shared among view controllers. It's also using UITabBar to keep using native iOS framework instead of UIButton and UIView, so you can assign the tab bar item directly from your UIViewController's tabBarItem property, reducing boilerplate code and easier migration process from native UITabBarController to AudioTabBarController.
                       DESC

  s.homepage         = 'https://github.com/hendych/AudioTabBarController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Hendy Christianto' => 'hendychrst90@gmail.com' }
  s.source           = { :git => 'https://github.com/hendych/AudioTabBarController.git', :tag => s.version.to_s }
  s.ios.deployment_target = '9.0'
  s.source_files = 'AudioTabBarController/Classes/**/*'
  s.resource_bundles = {
      'AudioTabBarController' => ['AudioTabBarController/Assets/*.xib']
  }
end
