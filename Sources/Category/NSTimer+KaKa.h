//
//  NSTimer+KaKa.h
//  KaKa
//
//  Created by 郭 健 on 15/1/27.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (KaKa)
-(void)pauseTimer;
-(void)resumeTimer;
-(void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;
@end
