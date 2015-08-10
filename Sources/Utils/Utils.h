//
//  Utils.h
//  KaKa
//
//  Created by 郭 健 on 15/2/13.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreGraphics/CGGeometry.h>
#import <UIKit/UIKit.h>

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

@interface Utils : NSObject

+(Utils*)sharedInstance;

#pragma mark -
#pragma mark time format
+(NSString*)getSinceTimeFromTimestamp:(NSString *)dateTime;
+(NSString*)getSinceTimeFromTimeInterval:(NSTimeInterval)dateTime;
+(NSString*)getTimeStringFromTimeInterval:(NSTimeInterval)dateTime withFormat:(NSString*)formatString;
+(NSString*)getTimeStringFromTimeInterval:(NSTimeInterval)dateTime;

#pragma mark - 
#pragma mark 字符串操作

#define isBlankObject(obj) [Utils isBlankObject:(obj)]
#define isBlankString(str) [Utils isBlankString:(str)]
//字符串是否为空串或者只有空格
+(BOOL)isBlankString:(NSString*)str;

//Object 是否为空，包含NSNumber、NSArray、NSdictionary等
+(BOOL)isBlankObject:(id)obj;

#pragma mark -
#pragma mark 存储关键信息userdefault操作
+(id) getValueFromKey:(NSString *)keyInDefaults;
+ (void) setValueForKey:(id)value key:(NSString *)key;

#pragma mark ---
#pragma mark UDID

+(NSString *)getUUIDFromKeychainItemWrapper;

#pragma mark
#pragma mark 计算长宽

#define adapt1242(num)  [Utils numberFrom1242:(num)]
#define adapt736(num)  [Utils numberFrom736:(num)]
#define adapt2208(num)  [Utils numberFrom2208:(num)]

+(float)numberFrom736:(float)number;
+(float)numberFrom2208:(float)number;
+(float)numberFrom1242:(float)number;

#pragma mark -
#pragma mark 随机数

#define kkRandomMax(max) [Utils kkRandom:((max))]
#define kkRandom(min,max) [Utils kkRandom:(min) toMax:(max)]
+(int)kkRandom:(int)max;//0~max,contains max
+(int)kkRandom:(int)min toMax:(int)max;//min~max,contains min and max

#pragma mark -
#pragma mark Device Type
+(NSString*)deviceType;

+(NSString*)getFilePath:(NSString*)path;
+(NSString*)getBundleFilePath:(NSString*)path;
#pragma mark -
#pragma mark 提示框
+(void)AlertString:(NSString*)str;


#pragma mark - 
#pragma mark text计算label尺寸
+(CGSize)contentHeightWithText:(NSString*)text withFont:(UIFont*)font withWidth:(float)width;
+(CGSize)contentSizeWithText:(NSString*)text withFont:(UIFont*)font;

#pragma mark - 
#pragma mark 计算经纬度距离
+(double)getdistanceFrom:(CLLocationCoordinate2D)source to:(CLLocationCoordinate2D)des;

#pragma mark -
#pragma mark 获取汉字拼音
+(NSString*)getPinyin:(NSString*)str;

#pragma mark - 
#pragma mark 拨打电话
+(BOOL)makePhoneCall:(NSString*)phoneNumber;
+(BOOL)makePhoneCallList:(NSString*)phoneNumbers onView:(UIView*)superView;

#pragma mark -
#pragma mark image url


#pragma mark BadgeNumberString
+(NSString*)getBadgeString:(NSInteger)number;

//
// Function   : appVersion
// Description: 获取app的版本号
// Input      :
// Output     :
// Return     : NSString *：app版本号
//
+ (NSString *)appVersion;
/**
 *  判断是否是第一次启动
 *
 *  @return 是否第一次
 */
+ (BOOL)isFirstLaunchStart;

//
// Function   : timestamp2Date
// Description: 时间戳转时间
// Input      :
//
// Output     :
// Return     : NSString *：转换后string
//
+ (NSString *)timestamp2Date:(long)aTimesamp;

//
// Function   : timestamp2Date2
// Description: 时间戳转时间
// Input      :
//
// Output     :
// Return     : NSString *：转换后string
//
+ (NSString *)timestamp2Date2:(long)aTimesamp type:(int)aType;

@end
