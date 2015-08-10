//
//  KKNoDataNextView.m
//  KaKa
//
//  Created by lihui on 15/6/9.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//  需要跳转到某一页面

#import "KKNoDataNextView.h"
#import "UIButton+KaKa.h"

@implementation KKNoDataNextView

- (id)initWithBgName:(NSString *)aBGName
{
    self = [super init];
    if (self)
    {
        self.goNextBtn = [[UIButton alloc] initWithBgImageName:aBGName];
        [self addSubview: self.goNextBtn];
    }
    
    return self;
}

/**
 *  <#Description#>
 *
 *  @param aTarget <#aTarget description#>
 *  @param aAction <#aAction description#>
 */
- (void) addTouch:(id)aTarget action:(SEL)aAction
{
    [self.goNextBtn addTarget:aTarget action:aAction forControlEvents:UIControlEventTouchUpInside];
}

@end
