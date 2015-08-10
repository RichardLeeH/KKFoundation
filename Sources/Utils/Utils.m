//
//  Utils.m
//  KaKa
//
//  Created by 郭 健 on 15/2/13.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "Utils.h"
//#import "KeychainItemWrapper.h"
#import "GCDMacros.h"

#define kUUIDKey @"kaka_UUIDKey"
#define IsFirstLaunchStart @"isFirstLaunchStart"

@interface Utils(/*Private Methods*/)<UIActionSheetDelegate>
+(NSString*)getUUID;
@end

@implementation Utils

+(Utils*)sharedInstance
{
    GCDSharedInstance(^{
        return [Utils new];
    })
}

#pragma mark -
#pragma mark time format

+(NSString *)getSinceTimeFromTimestamp:(NSString *)dateTime
{
    if (!dateTime) {
        return @"";
    }
    
    return [Utils getSinceTimeFromTimeInterval:[dateTime doubleValue]];
}

+(NSString*)getSinceTimeFromTimeInterval:(NSTimeInterval)dateTime
{
    NSTimeInterval  timeInterVal = [[NSDate date] timeIntervalSince1970];
    if (timeInterVal - dateTime < aMinute)
    {
        return @"刚刚";
    }
    else if (timeInterVal- dateTime < aHour)
    {
        int minuteNum = (timeInterVal - dateTime)/aMinute;
        return [NSString stringWithFormat:@"%d分钟前",minuteNum];
    }
    else if(timeInterVal - dateTime < aDay)
    {
        int hourNum = (timeInterVal - dateTime)/aHour;
        return [NSString stringWithFormat:@"%d小时前",hourNum];
    }
    else if(timeInterVal - dateTime < aWeek)
    {
        int dayNum = (timeInterVal - dateTime)/aDay;
        return [NSString stringWithFormat:@"%d天前",dayNum];
    }
    else if(timeInterVal - dateTime < aMouth)
    {
        int MouthNum = (timeInterVal - dateTime)/aWeek;
        return [NSString stringWithFormat:@"%d周前",MouthNum];
    }
    else
    {
        return [Utils getTimeStringFromTimeInterval:dateTime];
    }
}

+(NSString*)getTimeStringFromTimeInterval:(NSTimeInterval)dateTime
{
    return [Utils getTimeStringFromTimeInterval:dateTime withFormat:@"yyyy-MM-dd"];
}

+(NSString*)getTimeStringFromTimeInterval:(NSTimeInterval)dateTime withFormat:(NSString *)formatString
{
    NSString *ret;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:formatString];
    ret = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:dateTime]];
    return ret;
}

#pragma mark -
#pragma mark 字符串操作

+(BOOL)isBlankString:(NSString*)str
{
    if (str == nil || str == NULL
        || [str isKindOfClass:[NSNull class]]
        || [[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0
        || [str isEqualToString:@"(null)"]
        || [str isEqualToString:@"<null>"]
        || [str isEqualToString:@"null"])
    {
        return YES;
    }

    return NO;
}

+(BOOL)isBlankObject:(id)obj
{
    if (obj == nil || obj == NULL)
    {
        return YES;
    }
    
    if ([obj isKindOfClass:[NSNumber class]])
    {
        return [Utils isBlankString:[(NSNumber*)obj stringValue]];
    }
    
    if ([obj isKindOfClass:[NSNull class]])
    {
        return YES;
    }
    
    if ([obj isKindOfClass:[NSArray class]])
    {
        return [(NSArray*)obj count] == 0;
    }
    
    if ([obj isKindOfClass:[NSDictionary class]])
    {
        return [(NSDictionary*)obj count] == 0;
    }
    
    if ([obj isKindOfClass:[NSString class]])
    {
        return [Utils isBlankString:obj];
    }

    return YES;
}

#pragma mark -
#pragma mark 存储关键信息userdefault操作
+(id) getValueFromKey:(NSString *)keyInDefaults{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    id results = [defaults valueForKey:keyInDefaults];
    return results;
}

+ (void) setValueForKey:(id) value key:(NSString *) key{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:value forKey:key];
    [defaults synchronize];
}


#pragma mark --- UUID
#pragma mark UDID

+(NSString*)getUUID
{
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString * result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    
    CFRelease(puuid);
    CFRelease(uuidString);
    return result;
}

+(NSString *)getUUIDFromKeychainItemWrapper
{
    return @"ios";
//    KeychainItemWrapper *wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:kUUIDKey accessGroup:nil];
//    NSString * uuidString = [wrapper objectForKey:(__bridge id)kSecValueData];
//    
//    if (!uuidString || ![uuidString length]) {
//        uuidString = [Utils getUUID];
//        [wrapper setObject:uuidString forKey:(__bridge id)kSecValueData];
//    }
//    return uuidString;
}

#pragma mark
#pragma mark 计算长宽

+(float)numberFrom736:(float)number
{
    return number * KKSCREEN_HEIGHT / 736.0f;
}

+(float)numberFrom2208:(float)number
{
    return number * KKSCREEN_HEIGHT / 2208.0f;
}

+(float)numberFrom1242:(float)number
{
    return number * KKSCREEN_WIDTH / 1242.0f;
}

#pragma mark
#pragma mark 随机数

+(int)kkRandom:(int)max
{
    return arc4random() % (max + 1);
}

+(int)kkRandom:(int)min toMax:(int)max
{
    return min + [Utils kkRandom:(max - min)];
}

#pragma mark -
#pragma mark Device Type
+(NSString*)deviceType
{
    if (iPhone4) {
        return @"iphone4";
    }
    else if (iPhone5)
    {
        return @"iPhone5";
    }
    else if (iPhone6)
    {
        return @"iPhone6";
    }
    else if (iPhone6Plus)
    {
        return @"iPhone6Plus";
    }
    else
    {
        return @"unknown";
    }
}

+(NSString*)getFilePath:(NSString *)path
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDir = [paths objectAtIndex:0];
    
    NSString *ret = [docDir stringByAppendingPathComponent:path];
    return ret;
}

+(NSString*)getBundleFilePath:(NSString *)path
{
    return [[NSBundle mainBundle] pathForResource:path ofType:nil];
}
#pragma mark -
#pragma mark 提示框
+(void)AlertString:(NSString*)str{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:str delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark -
#pragma mark text计算label高度
+(CGSize)contentHeightWithText:(NSString*)text withFont:(UIFont*)font withWidth:(float)width
{    
    CGSize size = CGSizeMake(width, 20000.0f);//注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return size;
}

+(CGSize)contentSizeWithText:(NSString *)text withFont:(UIFont *)font
{
    CGSize size = CGSizeMake(20000.0f, 20000.0f);//注：这个宽：300 是你要显示的宽度既固定的宽度，高度可以依照自己的需求而定
    if ([[UIDevice currentDevice].systemVersion intValue] >= 7)//IOS 7.0 以上
    {
        NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
        size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading | NSStringDrawingUsesDeviceMetrics attributes:tdic context:nil].size;
    }
    
    return size;
}

+(double)getdistanceFrom:(CLLocationCoordinate2D)source to:(CLLocationCoordinate2D)des{
    CLLocation *orig=[[CLLocation alloc] initWithLatitude:source.latitude  longitude:source.longitude];
    CLLocation* dist=[[CLLocation alloc] initWithLatitude:des.latitude longitude:des.longitude ];
    
    CLLocationDistance kilometers=[orig distanceFromLocation:dist];
//    NSLog(@"距离:%f",kilometers);
    return kilometers;
}

#pragma mark -
#pragma mark 获取汉字拼音
+(NSString*)getPinyin:(NSString*)str
{
    NSMutableString *ms = [[NSMutableString alloc] initWithString:str];
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        NSLog(@"Pingying: %@", ms); // wǒ shì zhōng guó rén
    }
    
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
        NSLog(@"Pingying: %@", ms); // wo shi zhong guo ren
    }
    
    return [ms lowercaseString];
}

#pragma mark -
#pragma mark 拨打电话
+(BOOL)makePhoneCall:(NSString *)phoneNumber
{
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    if (phoneNumber.length < 5) {
        return NO;
    }
    
    NSMutableString * str= [[NSMutableString alloc] initWithFormat:@"telprompt://%@", phoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    
    return YES;
}

+(BOOL)makePhoneCallList:(NSString*)phoneNumbers onView:(UIView*)superView
{
    if (isBlankString(phoneNumbers)) {
        return NO;
    }
    
    NSArray *array = [phoneNumbers componentsSeparatedByString:@","];
    if (array.count > 1) {
        UIActionSheet *as = [[UIActionSheet alloc] initWithTitle:@"拨打电话" delegate:[Utils sharedInstance] cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
        for (NSString *number in array) {
            if (isBlankString(number) || number.length < 5) {
                continue;
            }
            
            [as addButtonWithTitle:number];
        }
        
        [as addButtonWithTitle:@"取消"];
        
        as.cancelButtonIndex = as.numberOfButtons - 1;
        
        [as showInView:superView];
    }
    else
    {
        return [Utils makePhoneCall:[array objectAtIndex:0]];
    }
    
    return YES;
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    
    [Utils makePhoneCall:[actionSheet buttonTitleAtIndex:buttonIndex]];
}


#pragma mark BadgeNumberString
+(NSString*)getBadgeString:(NSInteger)number
{
    if (number <= 0) {
        return @"";
    }
    
    return kkIntegerString(number);
}

//
// Function   : appVersion
// Description: 获取app的版本号
// Input      :
// Output     :
// Return     : NSString *：app版本号
//
+ (NSString *)appVersion
{
//    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+ (BOOL)isFirstLaunchStart
{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:IsFirstLaunchStart]) {
        return NO;
    }
    else{
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:IsFirstLaunchStart];
        [[NSUserDefaults standardUserDefaults] synchronize];
        return YES;
    }
    
}

//
// Function   : timestamp2Date
// Description: 时间戳转时间
// Input      :
//
// Output     :
// Return     : NSString *：转换后string
//
+ (NSString *)timestamp2Date:(long)aTimesamp
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimesamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:confromTimesp];
}

//
// Function   : timestamp2Date2
// Description: 时间戳转时间
// Input      :
//
// Output     :
// Return     : NSString *：转换后string
//
+ (NSString *)timestamp2Date2:(long)aTimesamp type:(int)aType
{
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:aTimesamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    
    if (1 == aType)
    {
        [formatter setDateFormat:@"yyyy-MM-dd"];
    }
    else
    {
        [formatter setDateFormat:@"yyyy/MM/dd"];
    }
    
    return [formatter stringFromDate:confromTimesp];
}

@end
