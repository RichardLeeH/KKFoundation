Pod::Spec.new do |s|

  s.name         = "KKFoundation"
  s.version      = "0.0.4"
  s.summary      = "A short description of KKFoundation."

  s.description  = <<-DESC
                   A longer description of KKFoundation in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/Richardlihui/KKFoundation"
  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "lihui" => "huili51@creditease.cn" }
  
  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/Richardlihui/KKFoundation.git", :tag => "0.0.1" }

  s.source_files  = "Sources", "Sources/**/*.{h,m}"
  s.exclude_files = "KKFoundation"
  s.resources = "Sources/Utils/ProgressHUD/ProgressHUD.bundle"
  s.frameworks = "Foundation", "UIKit"
  s.requires_arc = true

   s.dependency "FMDB"
   s.dependency "AFNetworking"
   s.dependency "GCDObjC"
   s.dependency "KVNProgress"
   s.dependency "JSONModel"
   s.dependency "SDWebImage"
   s.dependency "BJImageCropper"
   s.dependency "BlurImageProcessor"
   s.dependency "UIImage+Additions"
   s.dependency "UIImage+ImageCompress"
   s.dependency "UIImage-Resize"
   s.dependency "UIButton+TouchAreaInsets"
   s.dependency "Masonry"
   s.dependency "JSBadgeView"
   s.dependency "IQKeyboardManager"
   s.dependency "FSCalendar"
   s.dependency "SSLunarDate"
   
end
