//
//  UIButton+KaKa.m
//  KaKa
//
//  Created by 郭 健 on 15/1/26.
//  Copyright (c) 2015年 YiXin. All rights reserved.
//

#import "UIButton+KaKa.h"
#import "objc/runtime.h"
#import "Utils.h"
#import "UIView+KaKa.h"
#import "UIImage+KaKa.h"

@implementation UIButton (KaKa)

-(void)setImageWithName:(NSString *)name
{
    [self setImage:kkImageNamed(name) forState:UIControlStateNormal];
    [self setImage:kkImageHldNamed(name) forState:UIControlStateHighlighted];
}

-(id)initWithBgImageName:(NSString *)name
{
    self = [super init];
    
    UIImage *img = kkImageNamed(name);
    UIImage *imgHld = kkImageHldNamed(name);
    
    if (img) {
        self.kkSize = img.kkSize;
        [self setBackgroundImage:img forState:UIControlStateNormal];
        [self setBackgroundImage:imgHld forState:UIControlStateHighlighted];
    }
    
    return self;
}

-(id)initWithBgImageName:(NSString *)name withSize:(CGSize)size
{
    self = [self initWithBgImageName:name];
    self.kkSize = size;
    return self;
}

-(id)initWithTitle:(NSString *)title withFont:(UIFont *)font withColor:(UIColor *)color
{
    self = [super init];
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    self.titleLabel.font = font;
    
    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(20000,2000)];
    
    //RICHARD ADD    
    self.kkSize = size;//[Utils contentSizeWithText:title withFont:font];
    
    return self;
}

@end
