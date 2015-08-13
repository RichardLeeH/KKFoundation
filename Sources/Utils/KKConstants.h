//
//  KKConstants.h
//  KKFoundation
//
//  Created by lihui on 15/8/13.
//  Copyright (c) 2015年 lihui. All rights reserved.
//

#define kkFontWithSize(CGFloat)     [UIFont systemFontOfSize:CGFloat]
#define kkBoldFontSize(CGFloat)     [UIFont boldSystemFontOfSize:CGFloat]

#define STATUS_BAR_HEIGHT           (IS_IOS7?20:0)
#define NAV_BAR_HEIGHT              (IS_IOS7?64:44)

#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;
#define WO(weakObj, obj) __weak __typeof(&*obj)weakObj = obj;

#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//反射机制，通过类名获取类
#define KKClassFromName(className) NSClassFromString(className)

//获取本地化字符串
#define KKLocalString(strName) NSLocalizedString(strName, nil)


///网络状态改变通知
#define KKNetChangeNotification                @"kaka.netstatus.change"

#define kkIntegerString(num)     [[NSNumber numberWithInteger:(num)] stringValue]
#define kkDoubleString(num)      [[NSNumber numberWithDouble:(num)] stringValue]

#pragma mark - time
#define aMinute         60
#define aHour           (aMinute*60)
#define aDay            (aHour*60)
#define aWeek           (aDay*7)
#define aMouth          (aDay*30)
#define aYear           (aDay*365)

#define KKSCREEN_SIZE                 [[UIScreen mainScreen] bounds].size
#define KKSCREEN_HEIGHT               KKSCREEN_SIZE.height
#define KKSCREEN_WIDTH                KKSCREEN_SIZE.width

#define STATUS_BAR_HEIGHT           (IS_IOS7?20:0)
#define NAV_BAR_HEIGHT              (IS_IOS7?64:44)

#define SCREEN_HEIGHT_OF_IPHONE5    568
#define IS_IOS7                     (IOS_VERSION_CODE >= 7.0 )
#define ISLESS_IOS7                 (IOS_VERSION_CODE < 7.0)
#define is35InchScreen()            ([UIScreen mainScreen].bounds.size.height == 480)
#define is4InchScreen()             ([UIScreen mainScreen].bounds.size.height == SCREEN_HEIGHT_OF_IPHONE5)

#define iPhone4                     is35InchScreen()
#define iPhone5                     is4InchScreen()
#define iPhone6Plus                 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6                     ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define kkImageNamedWithCache(_pointer) kkImageNamed(_pointer)
#define kkImageName(_pointer) [UIImage createImage:(_pointer)]

#define kkHighlightName(name)           [NSString stringWithFormat:@"%@_hld", name]


#define kkImageNamed(_pointer)          [UIImage imageNamed:_pointer]

#define kkImageHldNamed(_pointer)       [UIImage imageNamed:kkHighlightName(_pointer)]
#define kkImageNamedFor2x(_pointer)     [UIImage imageNamedFor2X:_pointer]
#define kkImageNamedFor3x(_pointer)     [UIImage imageNamedFor3X:_pointer]
#define kkImageNamedFor6(_pointer)      [UIImage imageNamedFor6:_pointer]
#define kkImageNamedFor6Plus(_pointer)  [UIImage imageNamedFor6Plus:_pointer]


#define IOS_VERSION_CODE [[[UIDevice currentDevice] systemVersion] intValue]

