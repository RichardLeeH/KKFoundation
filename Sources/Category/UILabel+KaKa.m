//
//  UILabel+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/4/10.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "UILabel+KaKa.h"
#import "Utils.h"
#import "UIView+KaKa.h"

@implementation UILabel(KaKa)

-(CGSize)checkLabelSize:(BOOL)update
{
    if (self.font == nil) {
        return CGSizeZero;
    }
    
    CGSize ret = [Utils contentSizeWithText:self.text withFont:self.font];
    
    ret = CGSizeMake(ret.width + 2, ret.height);
    if (update) {
        self.kkSize = ret;
    }
    
    return ret;
}

@end
