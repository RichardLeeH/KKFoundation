//
//  UITextField+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/4/2.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "UITextField+KaKa.h"
#import "UIView+KaKa.h"

@implementation UITextField(KaKa)

-(void)setLeftOffset:(float)offset
{
    self.leftViewMode = UITextFieldViewModeAlways;
    UIView *leftView = [UIView new];
    leftView.kkWidth = offset;
    leftView.backgroundColor = [UIColor clearColor];
    self.leftView = leftView;
}


@end
