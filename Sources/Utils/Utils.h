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

#import "KKConstants.h"

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
