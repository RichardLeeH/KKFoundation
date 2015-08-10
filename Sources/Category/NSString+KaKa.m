//
//  NSString+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/4/10.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "NSString+KaKa.h"
#import "Utils.h"

@implementation NSString(KaKa)

-(NSTimeInterval)toTimeInterval
{
    return [self doubleValue] / 1000.0f;
}

-(NSString*)toDateString
{
    return [Utils getTimeStringFromTimeInterval:[self toTimeInterval]];
}

/**
 *  检测是否合法的手机号
 *
 *  @return
 */
- (BOOL)isValidateMobile
{
    //目前多了17手机号段
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}

/**
 *  检测是否合法的URL
 *
 *  @return
 */
- (BOOL)isValidateUrl
{
    NSString *urlRegex = @"^(https|http|ftp|rtsp|mms):\/\/(\\w+(-\\w+)*)(\\.(\\w+(-\\w+)*))+(\\?\\S*)?$";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",urlRegex];
    return [urlTest evaluateWithObject:self];
}

@end
