//
//  NSTimer+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/1/27.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "NSTimer+KaKa.h"

@implementation NSTimer (KaKa)
-(void)pauseTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate distantFuture]];
}


-(void)resumeTimer
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate date]];
}

- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval
{
    if (![self isValid]) {
        return ;
    }
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:interval]];
}

@end
