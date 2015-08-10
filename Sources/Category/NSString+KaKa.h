//
//  NSString+KaKa.h
//  KaKa
//
//  Created by 郭 健 on 15/4/10.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(KaKa)

-(NSTimeInterval)toTimeInterval;
-(NSString*)toDateString;

/**
 *  检测是否合法的手机号
 *
 *  @return
 */
- (BOOL)isValidateMobile;

/**
 *  检测是否合法的URL
 *
 *  @return
 */
- (BOOL)isValidateUrl;

@end
