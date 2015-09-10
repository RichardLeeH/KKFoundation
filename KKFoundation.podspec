
Pod::Spec.new do |s|

  s.name         = "KKFoundation"
  s.version      = "0.0.3"
  s.summary      = "Lighter view controllers."

  s.description  = <<-DESC
                   A longer description of KKFoundation in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  s.homepage     = "https://github.com/Richardlihui/KKFoundation"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  # ―――  Spec License  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Licensing your code is important. See http://choosealicense.com for more info.
  #  CocoaPods will detect a license file if there is a named LICENSE*
  #  Popular ones are 'MIT', 'BSD' and 'Apache License, Version 2.0'.
  #

  # s.license      = "MIT"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  # ――― Author Metadata  ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the authors of the library, with email addresses. Email addresses
  #  of the authors are extracted from the SCM log. E.g. $ git log. CocoaPods also
  #  accepts just a name if you'd rather not provide an email address.
  #
  #  Specify a social_media_url where others can refer to, for example a twitter
  #  profile URL.
  #

  s.author             = { "lihui" => "305516208@qq.com" }

  # ――― Platform Specifics ――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If this Pod runs only on iOS or OS X, then specify the platform and
  #  the deployment target. You can optionally include the target after the platform.
  #

  # s.platform     = :ios
  s.platform     = :ios, "7.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"


  # ――― Source Location ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Specify the location from where the source should be retrieved.
  #  Supports git, hg, bzr, svn and HTTP.
  #

  #s.source       = { :git => "https://github.com/yiyangest/KKTableView.git", :tag => s.version }
  s.source       = { :git => "https://github.com/Richardlihui/KKFoundation.git", :branch => "master" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "Sources", "Sources/**/*.{h,m}"
  s.exclude_files = "KKFoundation"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  s.resource  = "Sources/Utils/ProgressHUD/ProgressHUD.bundle"
  #s.resources = "Resources/*.png"
  s.framework  = "Foundation","UIKit"
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

