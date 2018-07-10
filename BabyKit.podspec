#
# Be sure to run `pod lib lint BabyKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'BabyKit'
  s.version          = '0.1.3'
  s.summary          = 'BabyKit 一个日常开发实用Objective-C工具包(部分代码参考或直接拷贝第三方框架).依赖多个实用Cocoapod依赖库，旨在快速提升开发效率，在实际开发过程中更加顺畅，没有很高大上的技术，就是单纯为了满足日常基本开发需求。'

  s.description      = <<-DESC
TODO: 针对已有的一系列类的demo编写待进行.....
                       DESC

  s.homepage         = 'https://github.com/baiwulong/BabyKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'baiwulong' => '1204803180@qq.com' }
  s.source           = { :git => 'https://github.com/baiwulong/BabyKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.requires_arc = true

  s.public_header_files = 'BabyKit/BabyKit.h'
  s.source_files = 'BabyKit/BabyKit.h'
  
  #依赖系统库
  s.frameworks = 'UIKit', 'Foundation'

# ==========================================================================================

s.subspec 'BabyHelper' do |helper|
    helper.ios.deployment_target = '8.0'
    helper.source_files = 'BabyKit/BabyHelper/*.{h,m}'
    helper.public_header_files = 'BabyKit/BabyHelper/*.h'
    helper.xcconfig = {
        'HEADER_SEARCH_PATHS' => '${PODS_ROOT}'
    }
end



# ==========================================================================================

s.subspec 'BabyCategory' do |category|
    category.ios.deployment_target = '8.0'
    category.source_files = 'BabyKit/BabyCategory/*.{h,m}'
    category.public_header_files = 'BabyKit/BabyCategory/*.h'
end

s.subspec 'BabyCustomView' do |view|
    view.ios.deployment_target = '8.0'
    view.source_files = 'BabyKit/BabyCustomView/*.{h,m}'
    view.public_header_files = 'BabyKit/BabyCustomView/*.h'
end

# ==========================================================================================

s.subspec 'BabyPodHelper' do |pod|
    pod.ios.deployment_target = '8.0'
    pod.source_files = 'BabyKit/BabyPodHelper/*.{h,m}'
    pod.public_header_files = 'BabyKit/BabyPodHelper/*.h'
    pod.xcconfig = {
        'HEADER_SEARCH_PATHS' => '${PODS_ROOT}'
    }
    pod.subspec 'BabyPodUIHelper' do |podUI|
        podUI.ios.deployment_target = '8.0'
        podUI.source_files = 'BabyKit/BabyPodHelper/BabyPodUIHelper/*.{h,m}'
        podUI.public_header_files = 'BabyKit/BabyPodHelper/BabyPodUIHelper/*.h'
        #UI控件组件
        podUI.dependency 'MJRefresh'                                  #刷新控件
        podUI.dependency 'MBProgressHUD'                              #提示文本
        podUI.dependency 'DZNEmptyDataSet','~> 1.8.1'                 #无网络，无数据等空白页设置
        podUI.dependency 'CRToast', '~> 0.0.9'                        #顶部弹窗提示控件
        podUI.dependency 'JPFPSStatus', '~> 0.1.1'                    #显示在状态栏FPS帧数
    end
    
    pod.subspec 'BabyPodToolHelper' do |podTool|
        podTool.ios.deployment_target = '8.0'
        podTool.source_files = 'BabyKit/BabyPodHelper/BabyPodToolHelper/*.{h,m}'
        podTool.public_header_files = 'BabyKit/BabyPodHelper/BabyPodToolHelper/*.h'
        
        #工具组件
        podTool.dependency 'FMDB','~> 2.7.2'                              #FMDB数据库操作
        podTool.dependency 'DateTools','~> 2.0.0'                         #时间日期操作
        podTool.dependency 'IQKeyboardManager', '~> 6.0.3'                #键盘辅助工具类
        podTool.dependency 'NullSafe', '~> 1.2.3'                         #null数据安全处理

        #调试或者系统辅助
        podTool.dependency 'CocoaLumberjack', '~> 3.4.1'                  #日志框架
        podTool.dependency 'FBRetainCycleDetector', '~> 0.1.4'            #Facebook开源的自动检测循环引用问题
#        podTool.dependency 'MLeaksFinder', '~> 1.0.0'                     #wechat开源的自动检测内存泄漏
    end
    
end




















end
